# variables.tf

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet within the VPC"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair"
  type        = string
}

variable "instance_type" {
  description = "The type of the instance"
  type        = string
  default     = "t3.nano"
}

variable "ami_id" {
  description = "The ID of the AMI to use for the instance"
  type        = string
}
variable "kms_key_id" {
  description = "The ID of the KMS key to use for EBS volume encryption"
  type        = string
}
variable "allowed_cidr" {
  description = "The CIDR block to allow RDP access from"
  type        = string
  default     = "0.0.0.0/0"  # Default to allow access from anywhere, replace with your desired CIDR block
}

