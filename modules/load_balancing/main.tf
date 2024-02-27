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
