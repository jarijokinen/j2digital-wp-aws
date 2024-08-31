resource "aws_vpc" "wp" {
  cidr_block = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_internet_gateway" "wp" {
  vpc_id = aws_vpc.wp.id
}

resource "aws_subnet" "private_a" {
  vpc_id = aws_vpc.wp.id
  cidr_block = "10.0.0.0/27"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_b" {
  vpc_id = aws_vpc.wp.id
  cidr_block = "10.0.0.32/27"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.wp.id
  cidr_block = "10.0.0.64/27"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "public_b" {
  vpc_id = aws_vpc.wp.id
  cidr_block = "10.0.0.96/27"
  availability_zone = "us-east-1b"
}
