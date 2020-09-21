#networking variables
variable "vpc_cidr" {}

variable "tenancy" {}

#variable "vpc_id" {
#    default = "${aws_vpc.main.id}"
#}

variable "private0_cidr" {}

variable "private1_cidr" {}

variable "private2_cidr" {}

variable "public0_cidr" {}

variable "public1_cidr" {}

variable "public2_cidr" {}