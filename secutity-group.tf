resource "aws_security_group" "sg-efs" {
    count       = var.create_efs && length(var.private_subnets_cidr) > 0 ? 1 : 0
    description = var.description
    vpc_id      = var.vpc_id
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(
        {
            "Name" = format("%s-", var.name)
        },
        var.tags,
        var.security_group_tags,
    )
}

resource "aws_security_group_rule" "ingress-rule" {
    count               = var.create_efs ? length(var.private_subnets_cidr) : 0
    type                = "ingress"
    security_group_id   = local.sg_id
    cidr_blocks         = [element(concat(var.private_subnets_cidr, [""]), count.index)]    
    from_port           = var.rules[var.security_group_ingress_rules[0]][0]
    to_port             = var.rules[var.security_group_ingress_rules[0]][1]
    protocol            = var.rules[var.security_group_ingress_rules[0]][2]
    description         = var.rules[var.security_group_ingress_rules[0]][3]
}