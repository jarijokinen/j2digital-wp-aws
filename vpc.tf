resource "aws_vpc" "wp" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "wp" {
  vpc_id = aws_vpc.wp.id
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.wp.id
  cidr_block        = "10.0.0.0/27"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.wp.id
  cidr_block        = "10.0.0.32/27"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.wp.id
  cidr_block        = "10.0.0.64/27"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.wp.id
  cidr_block        = "10.0.0.96/27"
  availability_zone = "us-east-1b"
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.wp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wp.id
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "wp" {
  name = "wp"
  vpc_id = aws_vpc.wp.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.wp.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.wp.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
