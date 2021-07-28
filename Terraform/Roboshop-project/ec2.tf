resource "aws_spot_instance_request" "cheap_worker" {
  count                 = length(var.COMPONENTS)
  ami                   = "ami-074df373d6bafa625"
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
  count                 = length(var.COMPONENTS)
  resource_id           = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id,count.index)
  key                   = "Name"
  value                 = element(var.COMPONENTS,count.index)
}
