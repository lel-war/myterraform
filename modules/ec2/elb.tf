#creating ALB as a front to our webservers
resource "aws_lb" "web" {
  name               = "terraform-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.sg-alb}"]
  subnets            = [ "${var.public0}", "${var.public1}", "${var.public2}"]

  enable_deletion_protection = false

}

#creating a target group to use with ALB
resource "aws_lb_target_group" "apache" {
  name     = "terraform-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

#creating ALB listener for port 80 and forward to previosly created target group
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.web.arn}"
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache.arn
  }
}
