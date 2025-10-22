variable "vpc_tag" {
  description = "VPC Name Tag value"
  type = string
  nullable = false
}

variable "region" {
  description = "AWS region to start instance"
  type = string
  nullable = false
}