provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-0e9bfdb247cc8de84"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name = "dhkim"


user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Kim Dae Hong" > index.html
              nohup busybox httpd -f -p ${var.http_port} &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "dhkim-WebSrv"
  }
}

resource "aws_security_group" "instance" {
  name = var.security_group_name

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}
