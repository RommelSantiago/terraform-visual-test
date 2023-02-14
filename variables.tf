variable "region" {
    type = string
    description = "The was region"
    default = "us-west-2"
}

variable "ami" {
    type = string
    description = "Ami used"
    default = "ami-0130c3a072f3832ff"
}

variable "instance_type" {
    type = string
    description = "The instance type"
    default = "t2.micro"
}