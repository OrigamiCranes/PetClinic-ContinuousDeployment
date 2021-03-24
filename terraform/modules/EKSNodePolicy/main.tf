# Create an IAM Role to allow our EKS service to manage other AWS services.

resource "aws_iam_role" "node_role" {
  name        = "FP-T1_node_role-${var.environment}"
  description = "Amazon EKS - ${var.environment} - Node Group Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action: "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name    = "${var.environment} - EKS Node Group Role"
    Project = "FP-T1"
  }
}

# Create an IAM Role policy which provides autoscaling permissions.

resource "aws_iam_role_policy" "eks_autoscaling_policy" {

  name       = "${var.environment}_eks_autoscaling_policy"
  role       = aws_iam_role.node_role.id
  depends_on = [aws_iam_role.node_role]

  policy     = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Resource = "*",
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions"
        ]
      }]
  })
}

# Attach the EKS Worker Node Policy to the role.

resource "aws_iam_role_policy_attachment" "eks_cluster_EKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_role.name
  depends_on = [aws_iam_role.node_role]
}

# Attach the EKS CNI Policy to the role.

resource "aws_iam_role_policy_attachment" "eks_cluster_EKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_role.name
  depends_on = [aws_iam_role.node_role]
}

# Attach the EC2 Container Registry Read Only Policy to this role.

resource "aws_iam_role_policy_attachment" "eks_cluster_CR_ReadOnly_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_role.name
  depends_on = [aws_iam_role.node_role]
}

# Attach the CloudWatch Logs Policy.

resource "aws_iam_role_policy_attachment" "CloudWatchLogsFullAccessPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role       = aws_iam_role.node_role.name
  depends_on = [aws_iam_role.node_role]
}