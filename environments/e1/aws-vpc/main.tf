module "create-vpc" {
	source  = "kb7ky.scalr.io/networking/create-vpc/aws"
	version = "0.0.1"

  vpc_parameters = {
    vpc1 = {
      name = var.vpc_tag
      cidr_block = "10.0.0.0/16"
      enable_ipv6 = true
      tags = {
        Name = var.vpc_tag
        tfref = var.vpc_tag
        Owner = "terraform"
      }
    }
  }
  subnetv4_parameters = {
    publicv4 = {
      cidr_block = "10.0.1.0/24"
      map_public_ip_on_launch = true     
      vpc_name   = "vpc1"
      tags = {
        Name = format("%s-%s",var.vpc_tag,"publicv4")
        tfref = format("%s-%s",var.vpc_tag,"publicv4")
        Owner = "terraform"
      }
    },
    privatev4 = {
      cidr_block = "10.0.128.0/24"
      vpc_name   = "vpc1"
      tags = {
        Name = format("%s-%s",var.vpc_tag,"privatev4")
        tfref = format("%s-%s",var.vpc_tag,"privatev4")
        Owner = "terraform"
      }
    }
  }
  subnetv6_parameters = {
    publicv6 = {
      assign_ipv6_address_on_creation = true
      ipv6_subnet = 2
      ipv6_native = true  
      vpc_name   = "vpc1"
      tags = {
        Name = format("%s-%s",var.vpc_tag,"publicv6")
        tfref = format("%s-%s",var.vpc_tag,"publicv6")
        Owner = "terraform"
      }
    }
    privatev6 = {
      assign_ipv6_address_on_creation = true
      ipv6_subnet = 128
      ipv6_native = true  
      vpc_name   = "vpc1"
      tags = {
        Name = format("%s-%s",var.vpc_tag,"privatev6")
        tfref = format("%s-%s",var.vpc_tag,"privatev6")
        Owner = "terraform"
      }
    }
  }
  igw_parameters = {
    igw1 = {
      vpc_name = "vpc1"
      tags = {
        Name = format("%s-%s",var.vpc_tag,"igw")
        tfref = format("%s-%s",var.vpc_tag,"igw")
        Owner = "terraform"
      }
    }
  }
  eigw_parameters = {
    eigw1 = {
      vpc_name = "vpc1"
      tags = {
        Name = format("%s-%s",var.vpc_tag,"eigw")
        tfref = format("%s-%s",var.vpc_tag,"eigw")
        Owner = "terraform"
      }
    }
  }
  rtv4_parameters = {
    rtigwv4 = {
      vpc_name = "vpc1"
      routes = [{
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw1"
        }
      ]
      tags = {
        Name = format("%s-%s",var.vpc_tag,"rtigwv4")
        tfref = format("%s-%s",var.vpc_tag,"rtigwv4")
        Owner = "terraform"
      }
    }
  }
  rtv6_parameters = {
    rtigwv6 = {
      vpc_name = "vpc1"
      routes = [{
        cidr_block = "::/0"
        use_igw = true
        gateway_id = "igw1"
        }
      ]
      tags = {
        Name = format("%s-%s",var.vpc_tag,"rtigwv6")
        tfref = format("%s-%s",var.vpc_tag,"rtigwv6")
        Owner = "terraform"
      }
    }
    rteigwv6 = {
      vpc_name = "vpc1"
      routes = [{
        cidr_block = "::/0"
        use_eigw = true
        gateway_id = "eigw1"
      }]
      tags = {
        Name = format("%s-%s",var.vpc_tag,"rteigwv6")
        tfref = format("%s-%s",var.vpc_tag,"rteigwv6")
        Owner = "terraform"
      }
    }
  }
  rt_associationv4_parameters = {
    assoc1 = {
      subnet_name = "publicv4"
      rt_name     = "rtigwv4"
    }
  }
  rt_associationv6_parameters = {
    assoc2 = {
      subnet_name = "publicv6"
      rt_name     = "rtigwv6"
    }
    assoc3 = {
      subnet_name = "privatev6"
      rt_name = "rteigwv6"
    }
  }
}
