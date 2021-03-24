provider "aws" {
  region     = "eu-west-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_instance" "firstinstance" {
  ami           = var.ami-id
  instance_type = var.type

  tags = {
    Name = "Terraform1"
  }
}
resource "aws_instance" "secondinstance" {
  ami           = var.ami-id
  instance_type = var.type

  tags = {
    Name = "Terraform2"
  }
}

module "SecurityGroups" {
  source = "./SecurityGroups"
  #depends_on = [module.Routing, module.VPC, module.Subnets]

  environment = var.environment
  cluster_name = local.cluster_name

  vpc_id = module.VPC.vpc_id

  controller_IP_CIDR = var.controller_IP_CIDR  # The IP address of our controller computer.

}