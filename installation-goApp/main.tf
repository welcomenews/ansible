#############################
#  Install GoApp --- ethr   #
#############################

variable "hcloud_token" {}
variable "ssh_key_rebrain" {}
variable "access_key_aws" {}
variable "secret_key_aws" {
}

provider "hcloud" {
  token = var.hcloud_token
}

# resource "hcloud_ssh_key" "default" {
#   name       = "Pub_key_rebrain"
#   fingerprint = var.ssh_key_rebrain
# }

data "hcloud_ssh_key" "default" {
  name        = "REBRAIN.SSH.PUB.KEY"
  fingerprint = var.ssh_key_rebrain
}

resource "hcloud_ssh_key" "my_key" {
  name       = "My id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "hcloud_server" "node1" {
  name  = "welcome-news"
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


variable "usr_pass" {
  default = 123456
}

resource "null_resource" "commands1" {

  provisioner "remote-exec" {
    inline = [
      "/bin/bash -c 'echo -e \"${var.usr_pass}\n${var.usr_pass}\" | passwd root'"
    ]
    # on_failure = continue
  }
  connection {
    user = "root"
    # password = "123456"
    host = hcloud_server.node1.ipv4_address
  }

  provisioner "local-exec" {
    command = <<EOT
    sleep 10;
    ssh-keyscan -H ${hcloud_server.node1.ipv4_address} >> ~/.ssh/known_hosts;
EOT
  }

   provisioner "local-exec" {
     command = "ansible-playbook -u root -i inventory.txt base.yml"
   }
  depends_on = [hcloud_server.node1]
}
