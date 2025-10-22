resource "aws_vpc" "this" {
  for_each             = var.vpc_parameters
  cidr_block           = each.value.cidr_block
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = each.value.enable_ipv6
  tags = each.value.tags
}

resource "aws_subnet" "thisv4" {
  for_each   = var.subnetv4_parameters
  vpc_id     = aws_vpc.this[each.value.vpc_name].id
  cidr_block = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  availability_zone = each.value.availability_zone
  tags = each.value.tags
}

resource "aws_subnet" "thisv6" {
  for_each   = var.subnetv6_parameters
  vpc_id     = aws_vpc.this[each.value.vpc_name].id
  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  ipv6_native = each.value.ipv6_native
  enable_resource_name_dns_aaaa_record_on_launch = true
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  ipv6_cidr_block = cidrsubnet(aws_vpc.this[each.value.vpc_name].ipv6_cidr_block,8,each.value.ipv6_subnet)
  availability_zone = each.value.availability_zone
  tags = each.value.tags
}

resource "aws_internet_gateway" "this" {
  for_each = var.igw_parameters
  vpc_id   = aws_vpc.this[each.value.vpc_name].id
  tags = each.value.tags
}

resource "aws_egress_only_internet_gateway" "thisv6" {
  for_each = var.eigw_parameters
  vpc_id   = aws_vpc.this[each.value.vpc_name].id
  tags = each.value.tags
}

resource "aws_route_table" "thisv4" {
  for_each = var.rtv4_parameters
  vpc_id   = aws_vpc.this[each.value.vpc_name].id
  tags = each.value.tags
  dynamic "route" {
    for_each = each.value.routes
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.use_igw ? aws_internet_gateway.this[route.value.gateway_id].id : route.value.gateway_id
    }
  }
}

resource "aws_route_table" "thisv6" {
  for_each = var.rtv6_parameters
  vpc_id   = aws_vpc.this[each.value.vpc_name].id
  tags = each.value.tags
  dynamic "route" {
    for_each = each.value.routes
    content {
      ipv6_cidr_block = route.value.cidr_block
      gateway_id = (route.value.use_igw ? aws_internet_gateway.this[route.value.gateway_id].id :
                   (route.value.use_eigw ? aws_egress_only_internet_gateway.thisv6[route.value.gateway_id].id :
                    route.value.gateway_id))
    }
  }
}

resource "aws_route_table_association" "thisv4" {
  for_each       = var.rt_associationv4_parameters
  subnet_id      = aws_subnet.thisv4[each.value.subnet_name].id
  route_table_id = aws_route_table.thisv4[each.value.rt_name].id
}

resource "aws_route_table_association" "thisv6" {
  for_each       = var.rt_associationv6_parameters
  subnet_id      = aws_subnet.thisv6[each.value.subnet_name].id
  route_table_id = aws_route_table.thisv6[each.value.rt_name].id
}
