output "vpcs" {
  description = "VPC Outputs"
  value       = { for vpc in aws_vpc.this : vpc.tags.Name => { "cidr_block" : vpc.cidr_block, "id" : vpc.id, "ipv6_cidr_block" : vpc.ipv6_cidr_block } }
}
