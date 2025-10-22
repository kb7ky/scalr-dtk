# Module - sg_app
# builds a sg for access

data "aws_vpc" "selected" {
  tags = { tfref = var.vpc_tag }
}

resource "aws_security_group" "sg_server" {
  name = format("%s-%s", var.vpc_tag, var.sg_name)
  description = format("SG for %s", var.sg_name)
  vpc_id = data.aws_vpc.selected.id

  tags = merge(var.tags, {
    Name : format("%s-%s", var.vpc_tag, var.sg_name)
    Owner = "terraform"
  })  
}

resource "aws_vpc_security_group_ingress_rule" "this_v4" {
  security_group_id = aws_security_group.sg_server.id
  for_each = var.apprulesv4
  description = each.value.name
  cidr_ipv4 = each.value.cidr_ipv4
  ip_protocol = each.value.ip_protocol
  to_port = each.value.to_port
  from_port = each.value.from_port
  tags = merge(var.tags, { Owner = "terraform" })
  referenced_security_group_id = each.value.referenced_security_group_id
}

resource "aws_vpc_security_group_ingress_rule" "this_v6" {
  security_group_id = aws_security_group.sg_server.id
  for_each = var.apprulesv6
  description = each.value.name
  cidr_ipv6 = each.value.cidr_ipv6
  ip_protocol = each.value.ip_protocol
  to_port = each.value.to_port
  from_port = each.value.from_port
  tags = merge(var.tags, { Owner = "terraform" })  
  referenced_security_group_id = each.value.referenced_security_group_id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_out_ipv4" {
  security_group_id = aws_security_group.sg_server.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_out_ipv6" {
  security_group_id = aws_security_group.sg_server.id
  cidr_ipv6 = "::0/0"
  ip_protocol = "-1"
}