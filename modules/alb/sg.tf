resource "aws_security_group" "this" {
  name        = "${var.name}-alb-sg"
  description = "Security Group for ALB ${var.name}"
  vpc_id      = data.aws_vpc.this.id
}

resource "aws_security_group_rule" "access_from_my_ip" {
  security_group_id = aws_security_group.this.id
  description       = "Allow connecting from my ip"

  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["${var.my_ip}/32"]
}

resource "aws_security_group_rule" "egress_anywhere" {
  security_group_id = aws_security_group.this.id
  description       = "Allow outbound traffic"

  type      = "egress"
  from_port = 8080
  to_port   = 8080
  protocol  = "all"
  # cidr_blocks = ["0.0.0.0/0"]
  source_security_group_id = var.instance_sg_id
}