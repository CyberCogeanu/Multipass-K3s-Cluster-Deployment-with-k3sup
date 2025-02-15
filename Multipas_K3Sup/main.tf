terraform {
  required_providers {
    multipass = {
      source  = "larstobi/multipass"
      version = "1.4.2"
    }
  }
}

resource "multipass_instance" "master" {
  count          = 3
  name           = "k3sup-master${count.index + 1}"
  cpus           = 1
  memory         = "2G"
  disk           = "10G"
  cloudinit_file = "${path.module}/k3sup-master.yaml"

}

resource "multipass_instance" "slave_nodes" {
  count          = 2 # Create two slave nodes
  name           = "k3sup-slave${count.index + 1}"
  cpus           = 1
  memory         = "2G"
  disk           = "10G"
  cloudinit_file = "${path.module}/k3sup-slave.yaml"
}

