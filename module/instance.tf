resource "aws_instance" "my_server" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet_a
}