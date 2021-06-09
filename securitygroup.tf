data "aws_vpc" "example" {
  tags = {
    "Name" = local.name
  }
}
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.example.id
}
resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = aws_db_instance.example.port
  to_port           = aws_db_instance.example.port
  protocol          = "tcp"
  cidr_blocks       = [var.vault_network_address]
  security_group_id = data.aws_security_group.default.id
}