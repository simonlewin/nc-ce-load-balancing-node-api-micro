variable "lb_target_grps" {
  type        = list(string)
  description = "The list of load balancer target groups"
}

variable "port" {
  type        = number
  description = "Port on which targets receive traffic"
}

variable "protocol" {
  type        = string
  description = "Protocol to use for routing traffic to the targets"
}

variable "vpc_id" {
  type        = string
  description = "Identifier of the VPC in which to create the target group"
}

variable "health_check" {
  type = object({
    path     = string
    protocol = string
  })
  description = "Destination and protocol for the health check request"
  default     = { path = "/health-check", protocol = "HTTP" }
}

variable "instance_ids" {
  type        = list(string)
  description = "List of IDs of the instances"
}
