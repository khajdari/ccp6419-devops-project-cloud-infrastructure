variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "ccp6419-configuration-server"
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}