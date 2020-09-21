
#get latest amazon linux 2 ami that supports EBS for persisting configurations on server
data "aws_ami" "amazon" {
  most_recent = true
  owners =[137112412989]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.2020*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}