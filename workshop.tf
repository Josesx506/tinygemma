terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = ""
  secret_key = ""
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Log the ami name for debugging purposes
output "ami_name" {
  # You can use wildcards like `*` to log more than one output e.g. ubuntu[*]
  value = data.aws_ami.ubuntu.name
}

resource "aws_security_group" "ssh_joses" {
  name        = "workshop-sg-joses-dev"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id = aws_security_group.ssh_joses.id
  cidr_ipv4         = "10.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.nano"

  root_block_device {
    tags = {
      Name = "workshop-ebs-dev"
    }
    volume_size = "10"
    volume_type = "gp3"
  }

  tags = {
    Name = "workshop-ec2-joses"
  }
}