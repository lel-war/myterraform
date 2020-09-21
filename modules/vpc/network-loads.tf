resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "private0" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.private0_cidr}"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private0"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.private1_cidr}"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.private2_cidr}"
  availability_zone = "us-east-1c"

  tags = {
    Name = "private2"
  }
}

resource "aws_subnet" "public0" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.public0_cidr}"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public0"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.public1_cidr}"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.public2_cidr}"
  availability_zone = "us-east-1c"

  tags = {
    Name = "public2"
  }
}

#let's create routes for public that go to the igw
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table_association" "public0" {
  subnet_id      = aws_subnet.public0.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}
#let's create routes for private that go to a ngw

resource "aws_eip" "ngw" {
  vpc      = true
}

resource "aws_eip" "vpn" {
  vpc      = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.ngw.id}"
  subnet_id = "${aws_subnet.public0.id}"
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ngw.id}"
  }
}

resource "aws_route_table_association" "private0" {
  subnet_id      = aws_subnet.private0.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

#ver el lifecycle hook, las subnets poner en que availabilityzone, la instancia tiene que tener una ip publica, ver arriba las 