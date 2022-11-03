resource "aws_security_group" "dh-sg" {
  vpc_id      = aws_vpc.dh-vpc.id
  name        = "T101 SG"
  description = "T101 Study SG"
}

resource "aws_security_group_rule" "dh-sg-inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dh-sg.id
}

resource "aws_security_group_rule" "dh-sg-outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dh-sg.id
}
