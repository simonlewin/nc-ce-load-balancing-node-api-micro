variable "cidr_range" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  description = "The Name tag for the VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "The list of availability zones for the subnets"
}

variable "public_subnets" {
  type        = list(string)
  description = "The list of IPv4 CIDR blocks for the public subnets"
}
