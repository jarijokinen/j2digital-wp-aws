resource "aws_vpc" "wp" {
  cidr_block = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_internet_gateway" "wp" {
  vpc_id = aws_vpc.wp.id
}

