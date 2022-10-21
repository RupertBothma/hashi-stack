variable "owner_name" {
  description = "Your name so resources can be easily assigned."
  type        = string
}
variable "owner_email" {
  description = "Your email so you can be contacted about resources."
  type        = string
}
variable "region" {
  description = "The AWS region to deploy into."
  type        = string
  default     = "eu-west-1"
}
variable "availability_zones" {
  description = "The AWS region AZs to deploy into."
  type        = list(string)
  default     = ["eu-west-1"]
}
variable "ami" {
  description = "The AMI to use, preferably built by the supplied Packer scripts."
  type        = string
}
variable "key_name" {
  description = "The EC2 key pair to use for EC2 instance SSH access."
  type        = string
}
variable "stack_name" {
  default = "hashistack"
}