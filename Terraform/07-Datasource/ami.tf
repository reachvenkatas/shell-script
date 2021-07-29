data "aws_ami" "example" {
  most_recent      = true
  name_regex       = "Centos*"
  owners           = ["973714476881"]
}

data "aws_ec2_spot_price" "example" {
  instance_type     = "t3.medium"
 // availability_zone = "us-west-2a"

  filter {
    name   = "product-description"
    values = ["Linux/UNIX"]
  }
}

output "image"  {
  value = data.aws_ami.example.id
}

output "image1"  {
  value = data.aws_ec2_spot_price.example
}