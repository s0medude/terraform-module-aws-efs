locals {
  efs_id = element(concat(aws_efs_file_system.efs.*.id, [""],), 0,)
  sg_id  = element(concat(aws_security_group.sg-efs.*.id, [""],), 0,)
}

resource "aws_efs_file_system" "efs" {
    count               = var.create_efs ? 1 : 0
    creation_token      = var.creation_token
    performance_mode    = var.performance_mode
    throughput_mode     = var.throughput_mode        
    depends_on          = [var.private_subnets]   
    tags = merge(
        {
            "Name" = format("%s-${var.efs_suffix}", var.name)
        },
        var.tags,
        var.efs_tags,
    )
}

resource "aws_efs_mount_target" "mount" {
    count            = var.create_efs && var.azs == length(var.private_subnets) ? var.azs : 0
    file_system_id   = local.efs_id
    subnet_id        = element(concat(var.private_subnets, [""]), count.index)     
    security_groups  = [local.sg_id]
    depends_on       = [aws_efs_file_system.efs]
}