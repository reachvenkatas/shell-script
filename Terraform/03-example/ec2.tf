resource "aws_instance" "sample" {
  ami                     = "ami-074df373d6bafa625"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Test"
 }
}

resource "aws_security_group" "allow_ssh" {
  name          = "allow_ssh"
  description   = "allow ssh"

  ingress {
    description      = "SSH"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}

provider "aws" {
  region = "us-east-1"
}

output "sg-attributes" {
  value = aws_security_group.allow_ssh
}
output "ec2-attr" {
  value = aws_instance.sample.public_ip
}

terraform {
  backend "s3" {
    bucket          = "venkata-devops"
    key             = "sample/terraform.tfstate"
    region          = "us-east-1"
    dynamodb_table  = "terraform"
  }
}

//data "template_file" "cool_script" {
//  template = "${file("${path.module}/script.sh")}"
//}
//  vars {
//    my_cool_var = "${var.my_cool_var}"
//  }
//}

//resource "null_resource" "script" {

 // # Trigger when the script when variables change
 // triggers = {
 //   my_trigger = "${var.my_cool_var}"
 //   script_sha = "${sha256(file("${path.module}/script.sh"))}"
 // }

  resource "null_resource" "run_shell_script" {
    triggers = {
      policy_sha1 = "${sha1(file("1.sh"))}"
    }
    provisioner "remote-exec" {
      connection {
        host                  = "aws_instance.sample.public_ip"
        user                  = "centos"
        password              = "DevOps321"
      }
      inline = [
        "cd /home/centos",
        "sh 1.sh"
      ]
    }
  }