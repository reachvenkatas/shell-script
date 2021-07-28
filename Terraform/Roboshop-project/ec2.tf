resource "aws_spot_instance_request" "cheap_worker" {
  count                 = LENGTH
  ami                   = "ami-074df373d6bafa625"
  vpc_security_group_ids = ["sg-08ef1bf4f4c3a2e31"]
  spot_price            = "0.03"
  spot_type             = "persistent"
  instance_interruption_behavior = "stop"
  instance_type         = "t3.micro"
  wait_for_fulfillment  = true
  tags          = {
    Name        = "${element(var.COMPONENTS,count.index)}-${count.index}-devops57"
  }
}

resource "aws_ec2_tag" "example" {
  count                 = LENGTH
  resource_id           = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id,count.index)
  key                   = "Name"
  value                 = element(var.COMPONENTS,count.index)
}

locals {
  LENGTH  = Length(var.COMPONENTS)
}

resource "null_resource" "run_shell_script" {
  count = LENGTH
  provisioner "remote-exec" {
    connection {
      host = element(aws_spot_instance_request.cheap_worker.*.public_ip,count.index)
      user = "centos"
      password = "DevOps321"
    }

    command = [
      "cd /home/centos",
      "git clone https://github.com/reachvenkatas/shell-script.git",
      "cd shell-script/roboshop",
      "sudo make ${element(var.COMPONENTS,count.index)}"
    ]
  }
}