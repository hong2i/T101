provider "aws" {
  region = "ap-northeast-2"
}

variable "development_environment" {
  description = "Create development environment Server"
  type        = list(string)
  default     = ["dev", "stg", "prd"]
}

resource "aws_instance" "server" {
  ami                    = "ami-0e9bfdb247cc8de84"
  instance_type          = "t2.micro"
  key_name = "dhkim"

  count = length(var.development_environment)
  tags = {
    Name = "var.development_environment[count.index] Server"
  }
}

output "ec2_name" {
  value       = [ for name in var.development_environment : name ]
}