variable "server_name" {
  type = list(string)
}

data "aws_ami" "amimumbai" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amimumbai.id
  instance_type = "t2.micro"
  for_each      = toset(var.server_name)
  tags = {
    Name = upper("${each.value}")
  }
}


output "private_ip" {
  description = "Printing the VALUE OF THE PRIVATE IP"
  value       = values(aws_instance.web)[*].private_ip
}
