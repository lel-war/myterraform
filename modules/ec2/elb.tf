resource "aws_lb" "web" {
  name               = "terraform-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.sg-alb}"]
  subnets            = [ "${var.public0}", "${var.public1}", "${var.public2}"]

  enable_deletion_protection = false

}

resource "aws_lb_target_group" "apache" {
  name     = "terraform-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.web.arn}"
  port              = "80"
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache.arn
  }
}

#resource "aws_lb_target_group_attachment" "web" {
#  target_group_arn = aws_lb_target_group.test.arn
#  target_id        = aws_instance.test.id
#  port             = 80
#}