# Create / define VPC's
resource "aws_vpc" "vpc1" {
  cidr_block = "${var.vpc_cidr_block_1}"

  tags = {
    appid = "${var.appid}"
    Name  = "${var.vpc_name}"
    automated = "yes"
  }
}
data "aws_availability_zones" "azs" {}

# Create / define sunbnets
resource "aws_subnet" "subnet1" {
  vpc_id                  = "${aws_vpc.vpc1.id}"
  cidr_block              = "${var.subnet_cidr_block_1}"
  availability_zone       = "${data.aws_availability_zones.azs.names[0]}"
  map_public_ip_on_launch = true

  tags = {
    appid = "${var.appid}"
    Name  = "pub_subnet1"
    type  = "public"
    automated = "yes"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id                  = "${aws_vpc.vpc1.id}"
  cidr_block              = "${var.subnet_cidr_block_2}"
  availability_zone       = "${data.aws_availability_zones.azs.names[1]}"
  map_public_ip_on_launch = true

  tags = {
    appid = "${var.appid}"
    Name  = "pub_subnet2"
    type  = "public"
    automated = "yes"
  }
}
resource "aws_subnet" "subnet3" {
  vpc_id                  = "${aws_vpc.vpc1.id}"
  cidr_block              = "${var.subnet_cidr_block_3}"
  availability_zone       = "${data.aws_availability_zones.azs.names[2]}"
  map_public_ip_on_launch = true

  tags = {
    appid = "${var.appid}"
    Name  = "pub_subnet3"
    type  = "public"
    automated = "yes"
  }
}

# Create / attach IGW to VPC 1
resource "aws_internet_gateway" "igw1" {
  vpc_id = "${aws_vpc.vpc1.id}"

  tags = {
    appid = "${var.appid}"
    Name  = "igw1"
  }
}
