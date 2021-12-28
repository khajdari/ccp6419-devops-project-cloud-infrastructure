variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "ccp6419-database-host"
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}

variable "mysql-source-address" {
  type    = string
  default = "*"
}