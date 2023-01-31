
# variable "ssh_key_rebrain" {
# }
#
variable "do_token_rebrain" {
}

variable "usr_pass" {
  default = 123456
}

# resource "digitalocean_ssh_key" "rebrain_ssh" {
#   name       = "REBRAIN_KEY"
#   public_key = var.ssh_key_rebrain
# }

data "digitalocean_ssh_key" "reb_key" {
  name = "REBRAIN.SSH.PUB.KEY"
}

data "digitalocean_ssh_key" "my" {
  name = "My_id_rsa"
}

# resource "digitalocean_ssh_key" "my" {
#   name       = "My_id_rsa"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

provider "digitalocean" {
  token = var.do_token_rebrain
}

resource "digitalocean_droplet" "node1" {
  image    = "ubuntu-18-04-x64"
  name     = "welcome-news"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.my.id, data.digitalocean_ssh_key.reb_key.id]
  provisioner "local-exec" {
    command = <<EOT
    sleep 16;
    echo [servers] >> inventory.txt;
    echo node1 ansible_host=${digitalocean_droplet.node1.ipv4_address} >> inventory.txt
EOT
  }
}

resource "null_resource" "root_password" {

  provisioner "remote-exec" {
    inline = [
      "/bin/bash -c 'echo -e \"${var.usr_pass}\n${var.usr_pass}\" | passwd root'"
    ]
    # on_failure = continue
  }
  connection {
    user = "root"
    # password = "123456"
    host = digitalocean_droplet.node1.ipv4_address
  }
  depends_on = [digitalocean_droplet.node1]
}

resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook -u root -i inventory.txt base.yml"
  }
  connection {
    user = "root"
    # password = "123456"
    host = digitalocean_droplet.node1.ipv4_address
  }
  depends_on = [null_resource.root_password]
}
