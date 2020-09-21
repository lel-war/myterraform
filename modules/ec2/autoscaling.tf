#creating ASG of webservers with configured launch config
resource "aws_autoscaling_group" "web" {
  name                      = "terraform-web*"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  launch_configuration      = aws_launch_configuration.web.name
  vpc_zone_identifier       = [ "${var.private0}", "${var.private1}", "${var.private2}"]

  tag {
    key                 = "Name"
    value               = "webserver-asg"
    propagate_at_launch = true
  }
}

# Creating a new ALB Target Group attachment to created target group
resource "aws_autoscaling_attachment" "asg_attachment_web" {
  autoscaling_group_name = aws_autoscaling_group.web.id
  alb_target_group_arn   = aws_lb_target_group.apache.arn
}