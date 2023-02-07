resource "aws_security_group" "this" {
  name        = "${var.name}-alb-sg"
  description = "Security Group for ALB ${var.name}"
  vpc_id      = data.aws_vpc.this.id
}

resource "aws_security_group_rule" "access_from_my_ip" {
  security_group_id = aws_security_group.this.id
  type        = "ingress"
  description = "Allow connecting from my ip to port 80"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["${var.my_ip}/32"]
}

resource "aws_security_group_rule" "egress_anywhere" {
  security_group_id = aws_security_group.this.id
  description       = "Allow outbound traffic"

  type      = "egress"
  from_port = var.tg_port
  to_port   = var.tg_port
  protocol  = "all"
  source_security_group_id = var.instance_sg_id
}
