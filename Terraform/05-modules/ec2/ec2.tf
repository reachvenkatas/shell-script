resource "aws_instance" "sample" {
  ami                     = "ami-074df373d6bafa625"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [var.SG_ID]

  tags = {
    Name = "Test"
  }
}

variable "SG_ID" {}

output "ec2-attr" {
  value = aws_instance.sample.public_ip
}