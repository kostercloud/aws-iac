resource "aws_s3_bucket" "lb_s3" {
  bucket = "ud-c1-lb"
  acl    = "private"

  tags = {
    appid = "${var.appid}"
    Name  = "UD-C1-LB"
    automated = "yes"
  }
}
