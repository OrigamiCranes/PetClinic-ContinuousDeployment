resource "aws_iam_role" "cluster_role" {
  name        = "FP-T1_cluster_role-${var.environment}"
  description = "Amazon EKS - ${var.environment} - Cluster Group Role"

  assume_role_policy =#??? jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Effect = "Allow"
      Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }]
  })

  tags = {
    Name    = "${var.environment} - EKS Cluster Role"
    Project = "FP-T1"
  }
}