#############################################
#  Create inventory file and install nginx  #
#############################################

variable "hcloud_token" {}
variable "ssh_key_rebrain" {}
variable "access_key_aws" {}
variable "secret_key_aws" {}

provider "hcloud" {
  token = var.hcloud_token
}

variable "instance" {
  type = map(any)
  default = {
    "node1" = 0
    "node2" = 1
  }
}

data "hcloud_ssh_key" "default" {
  name        = "REBRAIN.SSH.PUB.KEY"
  fingerprint = var.ssh_key_rebrain
}

resource "hcloud_ssh_key" "my_key" {
  name       = "My id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "null_resource" "inventory" {
  provisioner "local-exec" {
    command = "echo [servers] > inventory.txt;"
  }
}

resource "hcloud_server" "node1" {
  for_each    = var.instance
  name        = "welcome-news-${each.value}"
  image       = "ubuntu-18.04"
  server_type = "cx11"
  ssh_keys    = [data.hcloud_ssh_key.default.id, hcloud_ssh_key.my_key.name, ]
  labels      = { "module" : "devops", "email" : "welcome-news_at_mail_ru" }
  depends_on  = [null_resource.inventory]
}

resource "null_resource" "record_hosts" {
  for_each = var.instance
  provisioner "local-exec" {
    command = "echo welcome-news-${each.value} ansible_host=${hcloud_server.node1[each.key].ipv4_address} >> inventory.txt"
  }
  depends_on = [hcloud_server.node1]
}


provider "aws" {
  access_key = var.access_key_aws
  secret_key = var.secret_key_aws
  region     = "us-east-1"
}

# Так используем если зона уже есть
data "aws_route53_zone" "primary" {
  name = "devops.rebrain.srwx.net"
}

resource "aws_route53_record" "www" {
  for_each   = var.instance
  zone_id    = data.aws_route53_zone.primary.zone_id
  name       = "welcome-news-${each.value}.${data.aws_route53_zone.primary.name}"
  type       = "A"
  ttl        = "300"
  records    = [hcloud_server.node1[each.key].ipv4_address]
  depends_on = [null_resource.record_hosts]
}

variable "usr_pass" {
  default = 123456
}

resource "null_resource" "change_pass_root" {

  provisioner "remote-exec" {
    inline = [
      "/bin/bash -c 'echo -e \"${var.usr_pass}\n${var.usr_pass}\" | passwd root'"
    ]
    on_failure = continue
  }
  depends_on = [aws_route53_record.www]
  # depends_on = [hcloud_server.node1]
}

resource "null_resource" "ansible_playbook" {
  for_each = var.instance
  provisioner "local-exec" {
    command = "ssh-keyscan -H ${hcloud_server.node1[each.key].ipv4_address} >> ~/.ssh/known_hosts"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u root -i /home/sergey/terraform/less-ans12/inventory.txt nginx.yml"
  }
  depends_on = [null_resource.change_pass_root]
}
