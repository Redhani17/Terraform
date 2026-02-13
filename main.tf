resource "aws_instance" "dev_server" {
count=5
  ami           = var.ami_id
  instance_type = var.instance_type

  user_data = file("userdata.sh")

  tags = {
    Name = "server"
  }
}


