terraform {
  required_version = "~> 1.4.2"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {}

resource "digitalocean_droplet" "blogger" {
  image = "ubuntu-22-04-x64"
  name = "blogger"
  region = "fra1"
  size = "s-1vcpu-2gb"
  ssh_keys = [
    "ed:b5:ed:cb:c7:54:2b:1c:58:3a:22:5b:28:c8:a0:87",
    "e5:04:e9:c3:e8:a8:bf:3a:8c:82:22:d6:96:f3:03:9b"
  ]
  user_data = file("./cloud-init.yml")
}

resource "null_resource" "run_custom_script" {
  provisioner "local-exec" {
    command = "${path.module}/bin/cloud"
  }

  triggers = {
    droplet_id = digitalocean_droplet.blogger.id
    script_sha1 = filesha1("${path.module}/bin/cloud")
  }
}
