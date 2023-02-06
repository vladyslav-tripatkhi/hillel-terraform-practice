resource "aws_security_group" "my_host" {
  name        = "my_host"
  description = "Security Group for instances"
  vpc_id      = data.aws_vpc.this.id
}

resource "aws_security_group_rule" "access_from_my_ip" {
  security_group_id = aws_security_group.my_host.id
  type        = "ingress"
  for_each    = toset( ["22", "80"] )
  from_port   = each.key
  to_port     = each.key
  description = "Allow connecting from my ip to port ${each.key}"
  protocol    = "tcp"
  cidr_blocks = ["${local.my_ip}/32"]
}

resource "aws_security_group_rule" "access_from_alb" {
  security_group_id = aws_security_group.my_host.id
  description       = "Allow connecting from ALB"

  type                     = "ingress"
  from_port                = var.tg_port
  to_port                  = var.tg_port
  protocol                 = "tcp"
  source_security_group_id = module.alb.security_group_id
}

resource "aws_security_group_rule" "access_from_my_app" {
  security_group_id = aws_security_group.my_host.id
  description       = "Allow outbound traffic"

  type        = "egress"
  from_port   = -1
  to_port     = -1
  protocol    = "all"
  cidr_blocks = ["0.0.0.0/0"]
}