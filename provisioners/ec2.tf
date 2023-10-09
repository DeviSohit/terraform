resource "aws_instance" "provisioner" {
    ami = "ami-03265a0778a880afb"
    instance_type = "t2.micro"
    #security_groups = [aws_security_group.allow_all.name]

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory"
  }
}

resource "aws_instance" "remote" {
    ami = "ami-03265a0778a880afb"
    instance_type = "t2.micro"
    security_groups = ["sg-0d784987bc4c86087"] #allow-all security group id
    subnet_id = "subnet-0c6d0cfcd57cff7ec" #default vpc public subnet id

  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
    ]
  }
  }