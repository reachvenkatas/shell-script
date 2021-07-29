data "aws_ami" "example" {
  most_recent      = true
  name_regex       = "Centos*"
  owners           = ["973714476881"]
}

data "aws_ec2_spot_price" "example" {
  instance_type     = "t3.medium"
  //availability_zone = "us-west-2a"

}

output "image"  {
  value = data.aws_ami.example.id
}