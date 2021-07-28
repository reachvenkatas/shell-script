module "sg" {
  source = "./sg"
}
module "ec2"  {
  depends_on = [module.sg]
  source = "./ec2"
  SG_ID  = module.sg.sg-attributes
}

output "Public_IP" {
  value = module.ec2.ec2-attr
}

provider "aws" {
  region = "us-east-1"
}