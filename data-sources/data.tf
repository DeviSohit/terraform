data "aws_ami" "ami_id" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*.0-x86_64-gp2"]
  }
}

output "ami_id"{
    value = data.aws_ami.ami_id.id
}

data "aws_vpc" "default"{
    default = true
}

output "vpc_id_info"{
    value = data.aws_vpc.default
}

resource "aws_security_group" "allow_http" {
  name        = "allow-http"
  vpc_id = data.aws_vpc.default.id
  description = "Allow port 80"
  
  ingress { #inbound rules
    description      = "Allowing port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {  #outbound rules
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #all protocols
    cidr_blocks      = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "test-ami-datasource" {
  ami = data.aws_ami.ami_id.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_http.name]
}