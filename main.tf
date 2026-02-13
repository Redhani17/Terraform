provider "aws" {
  region = "eu-north-1"
}

# -----------------------------
# Security Group
# -----------------------------
resource "aws_security_group" "devops_sg" {

  name        = "devops-sg"
  description = "Allow SSH and Jenkins access"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
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

  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  user_data                   = file("userdata.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "DevOps-Server"
  }
}

# -----------------------------
# Variables
# -----------------------------
variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
}
