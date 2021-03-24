output "rds_sec_group_id" {
  description = "The ID of our RDS security group."
  value       = aws_security_group.rds_sec_group.id
}


output "k8s_node_sec_group_id" {
  description = "The ID of our node group security group.."
  value       = aws_security_group.k8s_node_sec_group.id
}



output "k8s_controller_sec_group_id" {
  description = "The ID of our K8s cluster controller security group."
  value       = aws_security_group.k8s_controller_sec_group.id
}