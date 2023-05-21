variable "region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  type        = string
}

variable "ipv4_cidr" {
  description = "VPC IPV4 CIDR"
  type = string
  default = "172.31.80.0/20"
}

variable "desired_size" {
  description = "The desired size of the EKS node group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum size of the EKS node group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "The minimum size of the EKS node group"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "The instance type to use for the EKS nodes"
  type        = string
  default     = "t3.medium"
}
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}