

provider "aws" {
  region = "us-east-2"
}

# Create a security group
resource "aws_security_group" "my_sg" {
  name        = "my_sg"
  description = "Example security group for EC2 instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 433
    to_port     = 433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 31110
    to_port     = 31110
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch an EC2 instance
resource "aws_instance" "my_ec2" {
    ami           = "ami-024e6efaf93d85776"

  instance_type = "t2.medium"

  vpc_security_group_ids = [aws_security_group.my_sg.id]
}
