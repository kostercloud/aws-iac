
data "aws_vpc" "available" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}
resource "aws_security_group" "web_sg" {
  name   = "web_sg"
  vpc_id = "${data.aws_vpc.available.id}"

  tags = {
    appid = "${var.appid}"
    Name  = "UD-C1-SG-WEB"
    automated = "yes"
  }
}
resource "aws_security_group" "app_sg" {
  name   = "app_sg"
  vpc_id = "${data.aws_vpc.available.id}"

  tags = {
    appid = "${var.appid}"
    Name  = "UD-C1-SG-APP"
    automated = "yes"
  }
}
resource "aws_security_group" "lb_sg" {
  name   = "lb_sg"
  vpc_id = "${data.aws_vpc.available.id}"

  tags = {
    appid = "${var.appid}"
    Name  = "UD-C1-SG-LB"
    automated = "yes"
  }
}
resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = "${data.aws_vpc.available.id}"

  tags = {
    appid = "${var.appid}"
    Name  = "UD-C1-SG-RDS"
    automated = "yes"
  }
}
# Create rules for Web SG
resource "aws_security_group_rule" "web_sg_rule_443_out" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"
  #self              = true
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow HTTPS out"
}
resource "aws_security_group_rule" "web_sg_rule_80_out" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"
  description       = "Allow HTTPS out"
  cidr_blocks       = ["0.0.0.0/0"]
}
/*resource "aws_security_group_rule" "web_sg_rule_22_out" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  description       = "Allow SSH out to my ip"
  security_group_id = "${aws_security_group.web_sg.id}"
  cidr_blocks       = ["162.247.81.45/32"]
}*/
resource "aws_security_group_rule" "web_sg_rule_ephemeral_ports_out" {
  type              = "egress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"
  self              = true
  description       = "Allow ephemeral ports out"
}
resource "aws_security_group_rule" "web_sg_rule_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"
  description       = "Allow HTTPS in"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "web_sg_rule_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"
  #self              = true
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow HTTPS in"
}

/*resource "aws_security_group_rule" "web_sg_rule_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  description       = "Allow SSH in from my ip"
  security_group_id = "${aws_security_group.web_sg.id}"
  cidr_blocks       = ["162.247.81.45/32"]
}*/
resource "aws_security_group_rule" "web_sg_rule_ephemeral_ports" {
  type              = "ingress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"
  self              = true
  description       = "Allow ephemeral ports in"
}
# Create rules for App SG
resource "aws_security_group_rule" "app_sg_rule_443" {
  type                  = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.app_sg.id}"
  self              = true
  description       = "Allow HTTPS in"
}
resource "aws_security_group_rule" "app_sg_rule_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.app_sg.id}"
  description       = "Allow HTTP in"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Create rules for App SG
resource "aws_security_group_rule" "lb_sg_rule_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.lb_sg.id}"
  self              = true
  description       = "Allow HTTPS in"
}
resource "aws_security_group_rule" "lb_sg_rule_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.lb_sg.id}"
  description       = "Allow HTTP in"
  cidr_blocks       = ["0.0.0.0/0"]
}