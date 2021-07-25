//resource "aws_instance" "sample" {
//  ami           = ami-074df373d6bafa625
//  instance_type = "t2.micro"
//
//  tags = {
//    Name = "Test"
// }
//}

resource "aws_security_group" "allow_tls" {
  name          = "allow_tls"
  description   = "Allow TLS"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 655535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

output "sg-attributes" {
  value = aws_security_group.allow_tls
}
provider "aws" {
  region = "us-east-1"
}
