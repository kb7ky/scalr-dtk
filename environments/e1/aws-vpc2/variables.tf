variable "region" {
  description = "AWS region to start instance"
  nullable = false
}

variable "vpc_tag" {
  description = "Tag to be used to create VPC"
  type = string
  nullable = false
}
