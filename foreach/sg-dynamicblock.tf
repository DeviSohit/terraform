resource "aws_security_group" "roboshop" {
  name        = "roboshop"
  description = "Allow HTTP HTTPS SSH"

  dynamic ingress { #Here ingress block is repetitive for allow 3 types of ports
    for_each = var.ingress #here you will get ingress variable
    content {
    description      = ingress.value["description"] #here ingress is dynamic block ingress
    from_port        = ingress.value.from_port #above one is same as this line.we can mention in any way
    to_port          = ingress.value.to_port
    protocol         = ingress.value.protocol
    cidr_blocks      = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "roboshop"
  }
}