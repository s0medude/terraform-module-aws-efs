output "efs_id" {
  description = "The id of the EFS resource created"
  value       = concat(aws_efs_file_system.efs.*.id, [""])[0]
}

output "efs_dns" {
  description = "The dns name of the EFS resource that will be mount"
  value       = concat(aws_efs_file_system.efs.*.dns_name, [""])[0]
}

output "efs_mount_target" {
  description = "List of the IDS of the mount target"
  value       = {}
  depends_on  = [aws_efs_mount_target.mount]
}

output "security_group_id_efs" {
  description = "The security group id assigned to the EFS"
  value       = aws_security_group.sg-efs.*.id
}

output "security_group_name_efs" {
  description = "The security group name assigned to the EFS"
  value       = concat(aws_security_group.sg-efs.*.name, [""])[0]
}
