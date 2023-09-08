resource "aws_instance" "multiple-instances" {
    count = 10 #10 instance will be created..count is one type of the loop 
    ami = var.ami_id
    instance_type = var.instance_names[count.index] == "MongoDB" || var.instance_names[count.index] == "MySQL" ? "t3.medium" : "t2.micro"
    tags = {
        Name = var.instance_names[count.index]
    }
}

resource "aws_route53_record" "records" {
  count = 10
  zone_id = var.hostedzone_id
  name    = "${var.instance_names[count.index]}.${var.domain}" #interpolation
  type    = "A"
  ttl     = 1
  records = [aws_instance.multiple-instances[count.index].private_ip]
}

output "private_ip" {
    value = [aws_instance.multiple-instances[*].private_ip]
}

resource "aws_key_pair" "deployer" {
  key_name   = "linux.pub"
  public_key = file("${path.module}/linux.pub")
}

resource "aws_instance" "file-functions" {
    ami = var.ami_id
    instance_type = "t2.micro"
    key_name = aws_key_pair.deployer.key_name
}