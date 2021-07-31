resource "aws_spot_instance_request" "cheap_worker" {
  count                 = local.LENGTH
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
  count                 = local.LENGTH
  resource_id           = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id,count.index)
  key                   = "Name"
  value                 = element(var.COMPONENTS,count.index)
}

resource "aws_route53_record" "records" {
  count                     = local.LENGTH
  name                      = element(var.COMPONENTS, count.index)
  type                      = "A"
  zone_id                   = "Z08761133VTY76N7SJWCJ"
  ttl                       = 300
  records                   = [element(aws_spot_instance_request.cheap_worker.*.private_ip, count.index)]
}

resource "null_resource" "run_shell_script" {
  count                     = local.LENGTH
  depends_on                = [aws_route53_record.records]
  provisioner "remote-exec" {
    connection {
      host                  = element(aws_spot_instance_request.cheap_worker.*.public_ip,count.index)
      user                  = "centos"
      password              = "DevOps321"
    }
    inline = [
      "cd /home/centos",
      "git clone https://github.com/reachvenkatas/shell-script.git",
      "cd shell-script/roboshop",
      "sudo make ${element(var.COMPONENTS,count.index)}"
    ]
  }
}
locals {
  LENGTH  = length(var.COMPONENTS)
}