# Create Application Load Balancer
resource "aws_lb" "applicationLoadBalancer" {

  name                       = "${var.projectName}-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [var.publicSubnetAz1ID, var.publicSubnetAz2ID, var.publicSubnetAz3ID]
  security_groups            = [var.nodeSecurityGroup]
  enable_deletion_protection = false

  tags = {
    Name = "${var.projectName}-alb"
    Env  = var.env
    Type = var.type
  }
}

# Create Listener that will listen on port 8000
resource "aws_lb_listener" "applicationLoadBalancerListener" {
  load_balancer_arn = aws_lb.applicationLoadBalancer.arn
  port              = 8000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.albTargetGroup.arn
  }

  tags = {
    Name = "${var.projectName}-alb-listener"
    Env  = var.env
    Type = var.type
  }
}

# Create Target Group
resource "aws_lb_target_group" "albTargetGroup" {
  name     = "${var.projectName}-tg-group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = var.vpcID

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    healthy_threshold   = var.health_check["healthy_threshold"]
    interval            = var.health_check["interval"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
    timeout             = var.health_check["timeout"]
    path                = var.health_check["path"]
    port                = var.health_check["port"]
  }

  tags = {
    Name = "${var.projectName}-alb-target-group"
    Env  = var.env
    Type = var.type
  }
}