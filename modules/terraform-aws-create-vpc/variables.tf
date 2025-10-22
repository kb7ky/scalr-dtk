variable "vpc_parameters" {
  description = "VPC parameters"
  type = map(object({
    name                 = string
    cidr_block           = string
    enable_dns_support   = optional(bool, true)
    enable_dns_hostnames = optional(bool, true)
    enable_ipv6          = optional(bool, false)
    tags                 = optional(map(string), {})
  }))
  default = {}
}


variable "subnetv4_parameters" {
  description = "Subnet parameters"
  type = map(object({
    cidr_block = string
    vpc_name   = string
    availability_zone = optional(string,null)
    tags       = optional(map(string), {})
    map_public_ip_on_launch = optional(bool, false)
  }))
  default = {}
}

variable "subnetv6_parameters" {
  description = "Subnet parameters"
  type = map(object({
    vpc_name   = string
    tags       = optional(map(string), {})
    assign_ipv6_address_on_creation = optional(bool, false)
    ipv6_native = optional(bool, false)
    map_public_ip_on_launch = optional(bool, false)
    ipv6_subnet = optional(number,0)
    availability_zone = optional(string,null)
  }))
  default = {}
}

variable "igw_parameters" {
  description = "IGW parameters"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "eigw_parameters" {
  description = "EIGW parameters"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "rtv4_parameters" {
  description = "RT V4 parameters"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string), {})
    routes = optional(list(object({
      cidr_block = string
      use_igw    = optional(bool, true)
      gateway_id = string
    })), [])
  }))
  default = {}
}
variable "rtv6_parameters" {
  description = "RT V6 parameters"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string), {})
    routes = optional(list(object({
      cidr_block = string
      use_igw    = optional(bool, false)
      use_eigw = optional(bool,false)
      gateway_id = string
    })), [])
  }))
  default = {}
}
variable "rt_associationv4_parameters" {
  description = "RT V4 association parameters"
  type = map(object({
    subnet_name = string
    rt_name     = string
  }))
  default = {}
}

variable "rt_associationv6_parameters" {
  description = "RT V6 association parameters"
  type = map(object({
    subnet_name = string
    rt_name     = string
  }))
  default = {}
}
