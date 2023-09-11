resource "aws_instance" "roboshop" {
    ami = var.ami_id
    instance_type=var.instance_type
}