resource "aws_alb" "tf_cloud_demo" {
  name                       = "tfclouddemo"
  load_balancer_type         = "application"
  internal                   = false
  subnets                    = aws_subnet.tf_cloud_demo_dmz_public_subnet.*.id
  security_groups            = [aws_security_group.loadbalancer_sg.id]
  enable_deletion_protection = false
  access_logs {
    bucket  = var.log_bucket
    prefix  = "alb"
    enabled = true
  }
}

resource "aws_lb_listener" "webserver_http" {
  load_balancer_arn = aws_alb.tf_cloud_demo.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_cloud_demo_target_group.arn
  }
}

resource "aws_lb_target_group" "tf_cloud_demo_target_group" {
  vpc_id      = aws_vpc.tf_cloud_demo_vpc.id
  protocol    = "HTTP"
  port        = 80
  target_type = "instance"
}