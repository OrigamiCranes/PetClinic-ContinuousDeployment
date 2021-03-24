variable "environment" {
  description = "The environment which this infrastructure will be running on."
  default = "This variable must be defined at environment level."
}

variable "vpc_id" {
  description = "The ID of the VPC belonging to each subnet."
  default = "This variable must be defined at environment level."
}

variable "private_eks_subnet_az_1_id" {
  description = "The AWS ID belonging to our private eks subnet 1."
  default     = "This variable must be defined at environment level."
}

variable "private_eks_subnet_az_2_id" {
  description = "The AWS ID belonging to our private eks subnet 2."
  default     = "This variable must be defined at environment level."
}

variable "public_subnet_az_1_id" {
  description = "The AWS ID belonging to our public subnet 1."
  default     = "This variable must be defined at environment level."
}

variable "public_subnet_az_2_id" {
  description = "The AWS ID belonging to our public subnet 2."
  default     = "This variable must be defined at environment level."
}

variable "rds_subnet_1_id" {
  description = "The AWS ID belonging to our rds subnet."
  default     = "This variable must be defined at environment level."
}

variable "rds_subnet_2_id" {
  description = "The AWS ID belonging to our rds subnet."
  default     = "This variable must be defined at environment level."
}