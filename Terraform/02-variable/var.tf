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
