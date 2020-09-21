#creating vpn/bastion instance
resource "aws_instance" "bastion" {
  ami           = "${data.aws_ami.amazon.id}"
  instance_type = "${var.instance_type}"
  security_groups = ["${var.sg-bastion}"]
  subnet_id = "${var.public0}"
  key_name = "${aws_key_pair.mykey.key_name}"
  associate_public_ip_address = true
  source_dest_check = false
  tags = {
    Name = "VPN Bastion"
  }
}

#associating this instance with a persistent IPv4 EIP
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.bastion.id
  allocation_id = "${var.vpn_eip}"
}