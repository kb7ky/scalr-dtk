provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "scalr" {
  ami                    = "ami-0326baaa98cf958ed"
  instance_type          = "t4g.micro"
  subnet_id              = "subnet-08367cb6ce26b6781"
  vpc_security_group_ids = ["sg-00e04930e4f562a32"]
  key_name               = "dtk-east-1"
}