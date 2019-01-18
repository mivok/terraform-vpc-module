variable "name" {
  description = "The name of the VPC. Also used as a prefix for other resources"
  default     = "myvpc"
}

variable "vpc_cidr" {
  description = "The address range of the VPC"
  default     = "172.22.136.0/21"
}

variable "subnet_count" {
  description = "How many subnets to create. This should be one for each AZ"
  default     = 3
}
