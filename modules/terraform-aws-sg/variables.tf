variable "apprulesv4" {
  description = "Parameters for App v4 rules"
  type = map(object({
    name = string
    cidr_ipv4 = optional(string,null)
    ip_protocol = string
    to_port = number
    from_port = number
    referenced_security_group_id = optional(string,null)
  }))
  default = {}
}

variable "apprulesv6" {
  description = "Parameters for App v6 rules"
  type = map(object({
    name = string
    cidr_ipv6 = optional(string,null)
    ip_protocol = string
    to_port = number
    from_port = number
    referenced_security_group_id = optional(string,null)
  }))
  default = {}
}

variable "vpc_tag" {
  description = "Tag Name value to select vpc"
  type        = string
  nullable    = false
}

variable "sg_name" {
  type = string
  description = "Name to create SG"
  nullable = false
}

variable "tags" {
  description = "Tags to be applied to the SG"
  type = map(string)
}
