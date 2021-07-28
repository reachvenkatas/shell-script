resource "aws_instance" "sample" {
  count                   = 2
  ami                     = "ami-074df373d6bafa625"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [var.SG_ID]

  tags = {
    Name = "Test.[count.index]"
  }
}

variable "SG_ID" {}

output "ec2-attr" {
  value = aws_instance.sample.*.public_ip
}