resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  vpc_id      = aws_vpc.tf_cloud_demo_vpc.id
  description = "used for access to the bastion instances from accessip"
}

resource "aws_security_group" "loadbalancer_sg" {
  name        = "loadbalancer_sg"
  vpc_id      = aws_vpc.tf_cloud_demo_vpc.id
  description = "used for access to the loadbalancer using HTTP, HTTPS from accessip"
}

resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  vpc_id      = aws_vpc.tf_cloud_demo_vpc.id
  description = "used for access to webserver from loadbalancer using HTTP, HTTPS and SSH form bastion host"
}

resource "aws_security_group_rule" "bastion_sg_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.accessip]
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.accessip]
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "loadbalancer_sg_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.accessip]
  security_group_id = aws_security_group.loadbalancer_sg.id
}

resource "aws_security_group_rule" "loadbalancer_sg_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.accessip]
  security_group_id = aws_security_group.loadbalancer_sg.id
}

resource "aws_security_group_rule" "loadbalancer_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.accessip]
  security_group_id = aws_security_group.loadbalancer_sg.id
}

resource "aws_security_group_rule" "webserver_sg_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id        = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "webserver_sg_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.loadbalancer_sg.id
  security_group_id        = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "webserver_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.accessip]
  security_group_id = aws_security_group.webserver_sg.id
}