data "aws_ami" "example" {
  executable_users = ["self"]
  most_recent      = true
  name_regex       = "Centos*"
  owners           = ["s973714476881"]
}

output "image"  {
  value = data.aws_ami.example
}