# -----------------------------
# Security Group
# -----------------------------
resource "aws_security_group" "devops_sg" {

  name        = "devops-sg"
  description = "Allow SSH and Jenkins access"

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins Access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DevOps-SG"
  }
}


# -----------------------------
# EC2 Instance
# -----------------------------
resource "aws_instance" "dev_server" {

  ami           = var.ami_id
  instance_type = var.instance_type

  associate_public_ip_address = true

  user_data = file("userdata.sh")

  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "ALLSERVERS"
  }
}
