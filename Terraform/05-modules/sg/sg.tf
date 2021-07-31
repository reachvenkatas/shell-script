resource "aws_security_group" "allow_ssh1" {
  name          = "allow_ssh1"
  description   = "allow ssh1"

  ingress {
    description      = "SSH"
    from_port        = 100
    to_port          = 200
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh1"
  }
}

output "sg-attributes" {
  value = aws_security_group.allow_ssh1.id
}

