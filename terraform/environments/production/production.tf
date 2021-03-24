variable "environment" {}
variable "region" {}
variable "maximum_node_group_size" {}
variable "desired_node_group_size" {}
variable "database_instance_class" {}
variable "DB_ROOT_PASSWORD" {}
variable "db_max_allocated_storage" {}
variable "controller_IP_CIDR" {}
variable "public_subnet_az_1_cidr_block" {}
variable "public_subnet_az_2_cidr_block" {}
variable "private_eks_subnet_az_1_cidr_block" {}
variable "private_eks_subnet_az_2_cidr_block" {}
variable "private_rds_1_cidr_block" {}
variable "private_rds_2_cidr_block" {}
variable "vpc_cidr_block" {}
variable "ssh_key_pair_name" {}
variable "eks_node_instance_types" {}

provider "aws" {
  region = var.region
}

module "infrastructure" {
  source = "../../modules/infrastructure"
  environment = var.environment

  # VPC Config
  vpc_cidr_block = var.vpc_cidr_block

  # Subnet Config
  public_subnet_az_1_cidr_block = var.public_subnet_az_1_cidr_block
  public_subnet_az_2_cidr_block = var.public_subnet_az_2_cidr_block

  private_eks_subnet_az_1_cidr_block = var.private_eks_subnet_az_1_cidr_block
  private_eks_subnet_az_2_cidr_block = var.private_eks_subnet_az_2_cidr_block

  private_rds_1_cidr_block = var.private_rds_1_cidr_block
  private_rds_2_cidr_block = var.private_rds_2_cidr_block

  # SSH Key Pair
  ssh_key_pair_name        = var.ssh_key_pair_name

  # EKS Scaling Configuration
  maximum_node_group_size  = var.maximum_node_group_size
  desired_node_group_size  = var.desired_node_group_size

  eks_node_instance_types  = var.eks_node_instance_types

  # Controller Machine Configuration
  controller_IP_CIDR       = var.controller_IP_CIDR

  # Database Configuration
  database_instance_class  = var.database_instance_class
  DB_ROOT_PASSWORD = var.DB_ROOT_PASSWORD
  db_max_allocated_storage = var.db_max_allocated_storage
}

output "rds_endpoint" {
  value = module.infrastructure.rds_endpoint
}