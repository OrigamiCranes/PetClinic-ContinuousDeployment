# ----- INTERNET GATEWAY -----

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name    = "${var.environment} - Internet Gateway"
    Project = "FP-T1"
  }
}

# ----- PUBLIC ROUTE TABLE -----

# Create a Public Route Table (associated with both public subnets).

resource "aws_route_table" "eks_public_route_table" {
  vpc_id = var.vpc_id

  route {
    # Public Route - FROM Internet Gateway DESTINATION 0.0.0.0/0
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name    = "${var.environment} - EKS Public Route Table"
    Project = "FP-T1"
  }
}

# Create Public Route Table Associations.

resource "aws_route_table_association" "eks_public_1_route_table_asc" {
  route_table_id = aws_route_table.eks_public_route_table.id
  subnet_id = var.public_subnet_az_1_id
}

resource "aws_route_table_association" "eks_public_2_route_table_asc" {
  route_table_id = aws_route_table.eks_public_route_table.id
  subnet_id = var.public_subnet_az_2_id
}

# ----- NAT GATEWAYS -----

# Create an Elastic IP for NAT Gateway AZ 1.

resource "aws_eip" "eip_nat_gateway_az_1" {
  vpc = true
}

# Create a NAT Gateway for Public AZ 1.

resource "aws_nat_gateway" "nat_gateway_az_1" {
  allocation_id = aws_eip.eip_nat_gateway_az_1.id
  subnet_id = var.public_subnet_az_1_id

  depends_on = [aws_eip.eip_nat_gateway_az_1]
}

# Create an Elastic IP for NAT Gateway AZ 2.

resource "aws_eip" "eip_nat_gateway_az_2" {
  vpc = true
}

# Create a NAT Gateway for Public AZ 1.

resource "aws_nat_gateway" "nat_gateway_az_2" {
  allocation_id = aws_eip.eip_nat_gateway_az_2.id
  subnet_id = var.public_subnet_az_2_id

  depends_on = [aws_eip.eip_nat_gateway_az_2]
}

# ----- PRIVATE ROUTE TABLE 1 -----

# Create Private Route 1, destination cidr 0.0.0.0/0 to NAT Gateway 1 ID

resource "aws_route_table" "eks_private_route_table_1" {
  vpc_id = var.vpc_id

  route {
    nat_gateway_id = aws_nat_gateway.nat_gateway_az_1.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name    = "${var.environment} - EKS Private Route Table AZ 1"
    Project = "FP-T1"
  }
}

# Create RT association with Private Subnet 1

resource "aws_route_table_association" "eks_private_route_table_1_asc" {
  route_table_id = aws_route_table.eks_private_route_table_1.id
  subnet_id = var.private_eks_subnet_az_1_id
}

# ----- PRIVATE ROUTE TABLE 2 -----

# Create Private Route 2, destination cidr 0.0.0.0/0 to NAT Gateway 2 ID

resource "aws_route_table" "eks_private_route_table_2" {
  vpc_id = var.vpc_id

  route {
    nat_gateway_id = aws_nat_gateway.nat_gateway_az_2.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name    = "${var.environment} - EKS Private Route Table AZ 2"
    Project = "FP-T1"
  }
}

# Create RT association with Private Subnet 2

resource "aws_route_table_association" "eks_private_route_table_2_asc" {
  route_table_id = aws_route_table.eks_private_route_table_2.id
  subnet_id = var.private_eks_subnet_az_2_id
}

# ----- RDS ROUTE TABLE -----

# Create Route Table, destination cidr 0.0.0.0/0 to Internet Gateway

resource "aws_route_table" "rds_route_table" {
  vpc_id = var.vpc_id

  route {
    gateway_id = aws_internet_gateway.internet_gateway.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name    = "${var.environment} - RDS Route Table"
    Project = "FP-T1"
  }
}

resource "aws_route_table_association" "rds_route_table_asc_az1" {
  depends_on = [aws_route_table.rds_route_table]
  route_table_id = aws_route_table.rds_route_table.id
  subnet_id = var.rds_subnet_1_id
}

resource "aws_route_table_association" "rds_route_table_asc_az2" {
  depends_on = [aws_route_table.rds_route_table]
  route_table_id = aws_route_table.rds_route_table.id
  subnet_id = var.rds_subnet_2_id
}