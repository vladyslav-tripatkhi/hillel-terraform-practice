resource "aws_alb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = data.aws_subnets.this.ids
}

resource "aws_lb_target_group" "this" {
  vpc_id   = data.aws_vpc.this.id
  name     = "${var.name}-target-group"
  port     = 8080
  protocol = "HTTP"

  health_check {
    interval = 10
    matcher  = "200"
    path     = "/"
    timeout  = 5
  }
}

resource "aws_lb_target_group_attachment" "this" {
  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.instance_ids[count.index]
  port             = 8080
}

resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    # type = "fixed-response"

    # fixed_response {
    #     content_type = "text/plain"
    #     message_body = "{\"message\": \"Hello from Terraform\"}"
    #     status_code  = "200"
    # }

    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
