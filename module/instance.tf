resource "aws_instance" "my_server" {
  ami           = var.ami
  instance_type = var.instance_type
}