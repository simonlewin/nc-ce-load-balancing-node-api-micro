resource "aws_lb_target_group" "load_balancer" {
  count = length(var.lb_target_grps)

  name     = var.lb_target_grps[count.index]
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    path     = var.health_check.path
    protocol = var.health_check.protocol
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_lb_target_group_attachment" "lb_group_attach" {
  count            = length(var.lb_target_grps)
  target_group_arn = aws_lb_target_group.load_balancer[count.index].arn
  target_id        = var.instance_ids[count.index]
  port             = var.port
}

resource "aws_lb" "lb" {
  name            = "lb"
  security_groups = var.security_groups
  subnets         = var.subnets

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer[2].arn
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_lb_listener_rule" "paths" {
  count = length(var.lb_target_grps)

  listener_arn = aws_lb_listener.front_end.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer[count.index].arn
  }

  condition {
    path_pattern {
      values = ["/api/${var.lb_target_grps[count.index]}*"]
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}
