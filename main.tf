# Webserver
resource "aws_instance" "web_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  user_data              = var.user_data
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  depends_on             = [aws_security_group.web_server_sg]
  tags = {
    Name = "web_server"
  }
}
