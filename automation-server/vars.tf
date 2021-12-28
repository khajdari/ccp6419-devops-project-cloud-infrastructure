variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "ccp6419-automation-server"
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}

variable "http-source-address" {
  type    = string
  default = "*"
}