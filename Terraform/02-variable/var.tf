variable "sample" {
  default = "Hello World"
}
variable "sample1" {
  default   = 10
}
variable "sample2" {
  default   = true
}
output "output" {
  value   = " var.sample , var.sample1 , var.sample2 ,  ${var.sample}, ${var.sample} , ${var.sample}  "
}

variable "train" {
  default =  "devops"
}
variable "train1" {
  default = [ "devops", "aws", 10 ]
}
variable "train3" {
  default = {
    aws     = "6am"
    devops  = 10
    azure   = true
  }
}

output "train" {
  value = var.train
}
output "train1" {
  value = var.train1[0]
}
output "train2" {
  value = var.train1
}

output "train3" {
  value = var.train3["aws"]
}

variable "FRUITS" {}
output "FRUITS" {
  value= var.FRUITS
}

variable "C" {}
output "C" {
  value = var.C
}

variable "SEASON" {}
output "SEASON" {
  value = var.SEASON
}
