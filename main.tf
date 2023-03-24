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
  ssh_keys = ["ed:b5:ed:cb:c7:54:2b:1c:58:3a:22:5b:28:c8:a0:87"]
  user_data = file("./blogger_app.yml")
}
