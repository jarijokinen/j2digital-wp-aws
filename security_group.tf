# Default

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

# DB

resource "aws_security_group" "db" {
  name = "db"
  vpc_id = aws_vpc.wp.id
}

resource "aws_vpc_security_group_ingress_rule" "db_allow_mysql_ipv4" {
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = aws_vpc.wp.cidr_block
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "db_allow_all_ipv4" {
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
