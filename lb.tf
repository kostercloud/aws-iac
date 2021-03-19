data "aws_vpc" "vpcid" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}
data "aws_subnet_ids" "data" {
  vpc_id = "${data.aws_vpc.vpcid.id}"

  tags = {
    type = "public"
  }
}

resource "aws_lb" "lb1" {
  name                       = "${var.lb_name}"
  internal                   = false
  load_balancer_type         = "${var.lb_type}"
  security_groups            = ["${aws_security_group.web_sg.id}"]
  subnets                    = "${data.aws_subnet_ids.data.ids}"
  enable_deletion_protection = false

  /*   access_logs {
    bucket  = "${aws_s3_bucket.lb_s3.id}"
    prefix  = "UD-C1"
    enabled = true
  } */

  tags = {
    appid = "${var.appid}"
    Name  = "UD-C1-LB"
    automated = "yes"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "${var.tg_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc1.id}"

  health_check {
    interval            = 15
    path                = "/index.html"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    appid = "${var.appid}"
    Name  = "UD-C1-TG"
    automated = "yes"
  }
}

resource "aws_lb_target_group_attachment" "web-attach-1" {
  target_group_arn = "${aws_lb_target_group.lb_target_group.arn}"
  target_id        = "${aws_instance.web1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "web-attach-2" {
  target_group_arn = "${aws_lb_target_group.lb_target_group.arn}"
  target_id        = "${aws_instance.web2.id}"
  port             = 80
}

resource "aws_lb_listener" "port_80_lb_listener" {
  load_balancer_arn = "${aws_lb.lb1.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_target_group.arn}"
  }
}