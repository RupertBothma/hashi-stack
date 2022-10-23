variable "created_email" { default = "rupert@al.co.za" }
variable "created_name" {default = "rupert" }
variable "region" { default = "eu-west-1" }

source "amazon-ebs" "hashistack" {
  ami_name      = "Hashistack {{timestamp}}"
  region        = var.region
  instance_type = "t3.medium"

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"] # Canonical's owner ID
    most_recent = true
  }

  communicator = "ssh"
  ssh_username = "ubuntu"

  tags = {
    OS_Version    = "Ubuntu"
    Release       = "20.04"
    Architecture  = "amd64"
    OWNER = var.created_email
    Created_Name  = var.created_name
  }
}

build {
  sources = [
    "source.amazon-ebs.hashistack"
  ]

  provisioner "shell" {
    inline = [
      "sudo mkdir -p /ops",
      "sudo chmod 777 /ops"
    ]
  }

  provisioner "file" {
    source      = "packer/"
    destination = "/ops"
  }

  provisioner "shell" {
    script = "packer/scripts/setup.sh"
  }
}