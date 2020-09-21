#creating launch configuration using provided key and installing and customizing index page in apache
resource "aws_key_pair" "mykey" {
  key_name   = "deployer-key"
  public_key = "${var.pub_key}"
}

resource "aws_launch_configuration" "web" {
  name_prefix   = "terraform-web*"
  image_id      = "${data.aws_ami.amazon.id}"
  instance_type = "${var.instance_type_web}"
  key_name = "${aws_key_pair.mykey.key_name}"
  security_groups = ["${var.sg-ag}"]
  user_data = "${var.userdata}"
  lifecycle {
    create_before_destroy = true
  }
}