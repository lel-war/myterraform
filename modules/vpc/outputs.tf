output "current_vpc" {
    value = "${aws_vpc.main.id}"
}

output "private0" {
    value = "${aws_subnet.private0.id}"
}

output "private1" {
    value = "${aws_subnet.private1.id}"
}

output "private2" {
    value = "${aws_subnet.private2.id}"
}

output "public0" {
    value = "${aws_subnet.public0.id}"
}

output "public1" {
    value = "${aws_subnet.public1.id}"
}

output "public2" {
    value = "${aws_subnet.public2.id}"
}

output "sg-alb"{
    value = "${aws_security_group.webpub.id}"
}

output "sg-ag"{
    value = "${aws_security_group.webpriv.id}"
}

output "sg-bastion"{
    value = "${aws_security_group.bastion.id}"
}

output "vpn_eip"{
    value = "${aws_eip.vpn.id}"
}

output "eip_ip4" {
    value = "${aws_eip.vpn.public_ip}"
}
