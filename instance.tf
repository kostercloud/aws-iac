
resource "aws_instance" "web1" {
  ami                    = "${lookup(var.ami, var.region)}"
  instance_type          = "${lookup(var.instance_type, var.region)}"
  availability_zone      = "${data.aws_availability_zones.azs.names[0]}"
  key_name               = "${var.keyname}"
  subnet_id              = "${aws_subnet.subnet1.id}"
  iam_instance_profile   = "${var.iaminstanceprofile}"
  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]

  root_block_device {
    volume_size = 12
    volume_type = "gp2"
  }

  tags = {
    Name  = "UD-C1-Web-Instance-1"
    appid = "${var.appid}"
  }
}

resource "aws_instance" "web2" {
  ami                    = "${lookup(var.ami, var.region)}"
  instance_type          = "${lookup(var.instance_type, var.region)}"
  availability_zone      = "${data.aws_availability_zones.azs.names[1]}"
  key_name               = "${var.keyname}"
  subnet_id              = "${aws_subnet.subnet2.id}"
  iam_instance_profile   = "${var.iaminstanceprofile}"
  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]

  root_block_device {
    volume_size = 12
    volume_type = "gp2"
  }

  tags = {
    Name      = "UD-C1-Web-Instance-2"
    automated = "yes"
    appid     = "${var.appid}"
  }
}


