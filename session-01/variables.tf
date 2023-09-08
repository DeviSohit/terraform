variable "ami_id" {
    type = string
    default = "ami-03265a0778a880afb" 
}

variable "instance_type" {
    #type = string #if you don't give this, terraform will understand automatically data types
    default = "t2.micro" 
}

variable "sg_name" {
    default = "allow-all"
}

variable "sg_cidr" {
    type = list
    default = ["0.0.0.0/0"]
}

variable "tags" {
    type = map
    default = {
        Name = "MongoDB"
        Environment = "DEV"
        Terraform = "true"
        Project = "Roboshop"
        Component = "MongoDB"
    }
}