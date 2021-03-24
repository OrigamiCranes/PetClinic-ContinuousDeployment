variable "environment" {
  description = "The env of the  belonging to each subnet."
  default     = "This variable must be defined at environment level."
}

variable "vpc_id" {
  description = "The ID of the VPC belonging to each subnet."
  default     = "This variable must be defined at environment level."
}

variable "controller_IP_CIDR" {
  description = "The IP CIDR of our controller machine, running Ansible, Jenkins, Kubectl etc..."
  default     = "This variable must be defined at environment level."
}

variable "cluster_name" {
  description = "The name of our cluster."
  default     = "This variable must be defined at environment level."
}