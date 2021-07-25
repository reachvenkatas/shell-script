variable "sample" {
  default = "Hello World"
}
output "output" {
  value   = " var.sample , var.sample1 , var.sample2 ,  ${var.sample}, ${var.sample} , ${var.sample}  "
}
variable "sample1" {
  value   = 10
}
variable "sample2" {
  value   = True
}
