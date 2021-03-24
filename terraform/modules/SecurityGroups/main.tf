# ----- RDS SECURITY GROUPS -----

# Create an RDS security group.

resource "aws_security_group" "rds_sec_group" {
  name        = "${var.environment}-rds_sec_group"
  description = "Allows specific devices to communicate with our rds instance."
  vpc_id      = var.vpc_id

  egress {
    # Allow full outbound communication by the RDS.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.environment} - RDS Security Group"
    Project = "FP-T1"
  }
}

# Add additional ingress rules to our rds security group.

resource "aws_security_group_rule" "rds_k8s_node_communication" {
  description = "Allow our k8s node group to communicate with the RDS."

  type = "ingress"

  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"

  security_group_id        = aws_security_group.rds_sec_group.id      # The security group to apply this rule to.
  source_security_group_id = aws_security_group.k8s_node_sec_group.id # The security group to allow access from.
}


resource "aws_security_group_rule" "rds_dev_communication" {
  description = "Allow our dev machine to communicate with the RDS."

  type = "ingress"

  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"

  security_group_id = aws_security_group.rds_sec_group.id # The security group to apply this rule to.
  cidr_blocks       = [var.controller_IP_CIDR]            # The IP CIDR to allow access from.
}

# ----- CLUSTER SECURITY GROUP -----

# https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html

# Create a cluster security group.

resource "aws_security_group" "k8s_controller_sec_group" {
  name        = "${var.environment}-k8s-controller_sec_group"
  description = "Allows specific devices to communicate with our kubernetes API server."
  vpc_id      = var.vpc_id

  egress {
    # Allow full outbound communication by the kubernetes API server.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.environment} - k8s Controller Security Group"
    Project = "FP-T1"
  }
}

# Create a node security group.

resource "aws_security_group" "k8s_node_sec_group" {
  name        = "${var.environment}-k8s-node_sec_group"
  description = "Security group for all of our nodes within the k8s cluster."
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                                        = "${var.environment} - k8s Node Security Group"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

# Add additional ingress rules to our cluster security group.

resource "aws_security_group_rule" "cluster_controller_pod_communication_HTTPS" {
  description = "Allow our pods to communicate with the kubernetes API Server over HTTPS."

  type = "ingress"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  security_group_id        = aws_security_group.k8s_controller_sec_group.id # The security group to apply this rule to.
  source_security_group_id = aws_security_group.k8s_node_sec_group.id       # The security group to allow access from.
}

resource "aws_security_group_rule" "cluster_controller_pod_communication_LOGS" {
  description = "Allow our pods to communicate with the kubernetes API Server over 10250."

  type = "ingress"

  from_port = 10250
  to_port   = 10250
  protocol  = "tcp"

  security_group_id        = aws_security_group.k8s_controller_sec_group.id # The security group to apply this rule to.
  source_security_group_id = aws_security_group.k8s_node_sec_group.id       # The security group to allow access from.
}

resource "aws_security_group_rule" "cluster_controller_developer_communication_HTTPS" {
  description = "Allow our development machine to communicate with the cluster API Server."

  type = "ingress"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  security_group_id = aws_security_group.k8s_controller_sec_group.id # The security group to apply this rule to.
  cidr_blocks       = [var.controller_IP_CIDR]                    # The IP CIDR to allow access from.
}

# Add additional ingress rules to our cluster node group.

resource "aws_security_group_rule" "node_communication" {
  description = "Allow our cluster nodes to communicate with each other."

  type = "ingress"

  from_port = 0
  to_port   = 65535
  protocol  = "-1"

  security_group_id        = aws_security_group.k8s_node_sec_group.id # The security group to apply this rule to.
  source_security_group_id = aws_security_group.k8s_node_sec_group.id # The security group to allow access from.
}

resource "aws_security_group_rule" "demo-node-ingress-cluster" {
  description = "Allows our pods to receive communication from the k8s API."

  type = "ingress"

  from_port = 1025
  to_port   = 65535
  protocol  = "tcp"

  security_group_id        = aws_security_group.k8s_node_sec_group.id       # The security group to apply this rule to.
  source_security_group_id = aws_security_group.k8s_controller_sec_group.id # The security group to allow access from.
}