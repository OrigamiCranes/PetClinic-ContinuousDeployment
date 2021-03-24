variable "environment" {
  description = "The environment which this infrastructure will be running on."
  default     = "This variable must be defined at environment level."
}

variable "vpc_cidr_block" {
  description = "The region which this infrastructure will be running in."
  default     = "This variable must be defined at environment level."
}

variable "cluster_name" {
  description = "The name of our cluster."
  default     = "This variable must be defined at environment level."
}