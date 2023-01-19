#############################################
#  Create inventory file and install nginx  #
#############################################

variable "hcloud_token" {}
variable "ssh_key_my" { }
variable "ssh_key_rebrain" {}
variable "access_key_aws" {}
variable "secret_key_aws" {}

provider "hcloud" {
  token = var.hcloud_token
}

data "hcloud_ssh_key" "default" {
  name        = "REBRAIN.SSH.PUB.KEY"
  fingerprint = var.ssh_key_rebrain
}

resource "hcloud_ssh_key" "my_key" {
  name       = "My id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "hcloud_server" "node1" {
  name  = "terraform-less-01"
  image = "ubuntu-18.04"
  # image       = "centos-7"
  server_type = "cx11"
  ssh_keys    = [data.hcloud_ssh_key.default.id, hcloud_ssh_key.my_key.name, ]
  labels      = { "module" : "devops", "email" : "welcome-news_at_mail_ru" }

  provisioner "local-exec" {
    command = <<EOT
        echo [servers] >> inventory.txt;
        echo node1 ansible_host=${hcloud_server.node1.ipv4_address} >> inventory.txt
EOT
  }
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
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "welcome-news.${data.aws_route53_zone.primary.name}"
  type    = "A"
  ttl     = "300"
  records = [hcloud_server.node1.ipv4_address]
  depends_on = [aws_route53_record.www]
}

variable "usr_pass" {
  default = 123456
}

resource "null_resource" "test" {

  provisioner "remote-exec" {
    inline = [
      "/bin/bash -c 'echo -e \"${var.usr_pass}\n${var.usr_pass}\" | passwd root'"
    ]
    on_failure = continue
  }
  depends_on = [aws_route53_record.www]
  # depends_on = [hcloud_server.node1]
}

resource "null_resource" "test2" {

  provisioner "local-exec" {
    command = "ssh-keyscan -H ${hcloud_server.node1.ipv4_address} >> ~/.ssh/known_hosts"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u root -i /home/sergey/terraform/less-ans10/inventory.txt nginx.yml --vault-password-file a_password_file"
  }
  depends_on = [null_resource.test]
}
