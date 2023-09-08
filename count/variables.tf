variable "ami_id" {
    type = string
    default = "ami-03265a0778a880afb" 
}

variable "instance_names" {
    type = list
    default = ["MongoDB", "MySQL", "Redis", "RabbitMQ", "Catalogue", "User", "Cart", "Shipping", "Payment", "Web"]
}

variable "hostedzone_id" {
    default = "Z0004719GP56M4P55PNZ"
}

variable "domain" {
    default = "devidevops.online"
}