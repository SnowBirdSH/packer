variable "region" {
type = string
default = "eu-west-2"
}
variable "keypair_name" {
type = string
default = "test-packer"
}
variable "omi_source" {
type = string
default = "ami-044c54f9"
}
source "outscale-bsu" "ubuntu_2404" {
region = var.region
vm_type = "tinav5.c2r4p2"
ssh_username = "outscale"
communicator = "ssh"
ssh_interface = "public_ip"
ssh_keypair_name = var.keypair_name
source_omi = var.omi_source
omi_name = "ubuntu_2404_tp4"
ssh_private_key_file = "~/.ssh/outscale_test-packer.rsa"
launch_block_device_mappings {
delete_on_vm_deletion = true
device_name = "/dev/sda1"
volume_size = "40"
volume_type = "gp2"
}
}
build {
name = "ubuntu_2404_tp4"
sources = ["source.outscale-bsu.ubuntu_2404"]
provisioner "shell" {
    inline = [
    "cloud-init status --wait",
    "sudo apt update"
]
}
provisioner "ansible" {
    playbook_file = "playbook.yml"
}
provisioner "shell-local" {
    inline = ["pytest -v --hosts=ssh://outscale@${build.Host}"]
}
}
