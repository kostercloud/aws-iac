variable "access_key" {
  type = "string"
}
variable "secret_key" {
  type = "string"
}
variable "region" {
  type = "string"
}
variable "vpc_name" {
  type = "string"
}
variable "vpc_cidr_block_1" {
  type = "string"
}
variable "subnet_cidr_block_1" {
  type = "string"
}
variable "subnet_cidr_block_2" {
  type = "string"
}
variable "subnet_cidr_block_3" {
  type = "string"
}
variable "keyname" {
  type = "string"
}
variable "appid" {
  type = "string"
}
variable "iaminstanceprofile" {
  type = "string"
}
variable "lb_name" {
  type = "string"
}
variable "lb_type" {
  type        = "string"
  default     = "application"
  description = "accepts application or network"
}

variable "tg_name" {
  type = "string"
}


variable "name" {
  type = "map"
  default = {
    dev  = "josiecatbucket"
    tech = "bootsiecatbucket"
  }
}
variable "ami" {
  type = "map"
  default = {
    us-east-1 = "ami-062f7200baf2fa504"
    us-east-2 = "ami-02ccb28830b645a41"
  }
}
variable "instance_type" {
  type = "map"
  default = {
    us-east-1 = "t2.small"
    us-east-2 = "t2.medium"
  }
}
