# Override from command line if desired
data "aws_vpc" "selected" {
  tags = { Name = var.vpc_tag }
}

module "sg_access" {
	source  = "kb7ky.scalr.io/networking/sg/aws"
	version = "0.0.1"
  sg_name = "access"

  vpc_tag = var.vpc_tag
  tags = { tfref = format("%s-%s", var.vpc_tag,"access") }
  apprulesv4 = {
    r1 = {
      name = "dtkv4"
      cidr_ipv4 = "68.3.133.22/32"
      ip_protocol = "all"
    }
    r1 = {
      name = "ctk"
      cidr_ipv4 = "68.226.100.129/32"
      ip_protocol = "all"
    }
  }
  apprulesv6 = {
    r1 = {
      name = "dtkv6"
      cidr_ipv6 = "2600:8800:1800:111::0/64"
      ip_protocol = "all"
    }
  }
}

module "sg_nfssrvr" {
	source  = "kb7ky.scalr.io/networking/sg/aws"
	version = "0.0.1"
  sg_name = "nfssrvr"
  vpc_tag = var.vpc_tag
  tags = { tfref = format("%s-%s", var.vpc_tag,"nfssrvr") }

  apprulesv4 = {
    r1 = {
      cidr_ipv4 = data.aws_vpc.selected.cidr_block
      ip_protocol = "tcp"
      to_port = 2049
      from_port = 2049
    }
  }
}

module "sg_apps" {
	source  = "kb7ky.scalr.io/networking/sg/aws"
	version = "0.0.1"
  sg_name = "apps"
  vpc_tag = var.vpc_tag
  tags = { tfref = format("%s-%s", var.vpc_tag,"app") }
  apprulesv4 = {
    r1 = {
      name = "Brokers"
      cidr_ipv4 = data.aws_vpc.selected.cidr_block
      ip_protocol = "tcp"
      to_port = 7999
      from_port = 6000      
    }
    r2 = {
      name = "admctl web"
      cidr_ipv4 = data.aws_vpc.selected.cidr_block
      ip_protocol = "tcp"
      to_port = 5758
      from_port = 5758      
    }
    r3 = {
      name = "gatekeeper web"
      cidr_ipv4 = data.aws_vpc.selected.cidr_block
      ip_protocol = "tcp"
      to_port = 3900
      from_port = 3900      
    }
    r3 = {
      name = "logio"
      cidr_ipv4 = data.aws_vpc.selected.cidr_block
      ip_protocol = "tcp"
      to_port = 6689
      from_port = 6688      
    }
    r4 = {
      name = "logio"
      ip_protocol = "tcp"
      to_port = 6689
      from_port = 6688
      referenced_security_group_id = module.sg_whitelist.security_group_id    
    }
  }
}

module "sg_whitelist" {
	source  = "kb7ky.scalr.io/networking/sg/aws"
	version = "0.0.1"
  sg_name = "whitelist"
  vpc_tag = var.vpc_tag
  tags = { tfref = format("%s-%s", var.vpc_tag,"whitelist") }
  apprulesv4 = {
    r1 = {
      name = "dtkv4"
      cidr_ipv4 = "68.3.133.22/32"
      ip_protocol = "all"
    }
    r1 = {
      name = "ctk"
      cidr_ipv4 = "68.226.100.129/32"
      ip_protocol = "all"
    }
  }
  apprulesv6 = {
    r1 = {
      name = "dtkv6"
      cidr_ipv6 = "2600:8800:1800:111::0/64"
      ip_protocol = "all"
    }
  }
}

module "sg_bastion" {
	source  = "kb7ky.scalr.io/networking/sg/aws"
	version = "0.0.1"

  vpc_tag = var.vpc_tag
  sg_name = "bastion"
  tags = { tfref = format("%s-%s", var.vpc_tag,"bastion") }
  apprulesv4 = {
    r1 = {
      name = "bastion1"
      cidr_ipv4 = "0.0.0.0/0"
      ip_protocol = "tcp"
      to_port = 22
      from_port = 22      
    }
  }
}