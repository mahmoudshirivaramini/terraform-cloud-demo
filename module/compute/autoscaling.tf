data "aws_ami" "server_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

data "template_file" "webserver_init" {
  template = "${file("${path.module}/templates/webserver_init.tpl")}"
}

resource "aws_launch_configuration" "bastion-launchconfig" {
  name_prefix     = "bastion-launchconfig"
  image_id        = data.aws_ami.server_ami.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.tf_cloud_demo.key_name
  security_groups = [var.bastion_sg]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion-autoscaling" {
  name                 = "bastion-autoscaling"
  vpc_zone_identifier  = [join(", ", var.dmz_public_subnets)]
  launch_configuration = aws_launch_configuration.bastion-launchconfig.name
  min_size             = 2
  desired_capacity     = 2
  max_size             = 4
  tag {
    key                 = "Name"
    value               = "bastion"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "webserver-launchconfig" {
  name_prefix     = "webserver-launchconfig"
  image_id        = data.aws_ami.server_ami.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.tf_cloud_demo.key_name
  security_groups = [var.webserver_sg]
  user_data       = data.template_file.webserver_init.rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "webserver-autoscaling" {
  name                      = "webserver-autoscaling"
  vpc_zone_identifier       = [join(", ", var.app_private_subnets)]
  launch_configuration      = aws_launch_configuration.webserver-launchconfig.name
  min_size                  = 2
  desired_capacity          = 2
  max_size                  = 10
  health_check_grace_period = 60
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = [var.target_group_arn]
  depends_on                = [var.alb_dns_name]
  tag {
    key                 = "Name"
    value               = "webserver"
    propagate_at_launch = true
  }
}