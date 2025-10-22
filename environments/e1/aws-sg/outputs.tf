output "access_security_group_name" {
  description = "Access SG-name"
  value = module.sg_access.security_group_name
}

output "access_security_group_id" {
  description = "Access SG ID"
  value = module.sg_access.security_group_id
}

output "whitelist_security_group_name" {
  description = "WhiteList SG-name"
  value = module.sg_whitelist.security_group_name
}

output "whitelist_security_group_id" {
  description = "WhiteList SG ID"
  value = module.sg_whitelist.security_group_id
}

output "nfssrvr_security_group_name" {
  description = "NFS Servers SG-name"
  value = module.sg_nfssrvr.security_group_name
}

output "nfssrvr_security_group_id" {
  description = "NFS Servers SG ID"
  value = module.sg_nfssrvr.security_group_id
}