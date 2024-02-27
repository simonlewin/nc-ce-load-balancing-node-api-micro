variable "servers" {
  type    = list(string)
  description = "The list of servers for the instance"
}

variable "instance_type" {
  type    = string
  description = "The instance type for the instance"
  default = "t2.micro"
}

variable "vpc_security_group_ids" {
  type = list(string)
  description = "List of security group IDs to associate with."
}

variable "key_name" {
  type    = string
  description = "Key name of the Key Pair to use for the instance"
  default = "nc-photo-display-app"
}

variable "ami" {
  type    = string
  description = "AMI to use for the instance"
  default = "ami-0e5f882be1900e43b"
}

variable "subnets" {
  type = list(string)
}
