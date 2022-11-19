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

output "for_server_output" {
  value = "%{ for i, name in var.development_environment }${i+1}. ${name} Server\n%{ endfor }"
}

output "for_server_output2" {
  value = <<EOF
  %{~ for i, name in var.development_environment ~}
  ${i+1}. ${name}%{ if i < length(var.development_environment) - 1 }%{ endif } Server
  %{~ endfor ~}
  EOF
}