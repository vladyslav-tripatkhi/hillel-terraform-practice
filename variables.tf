locals {
  my_ip = chomp(data.http.myip.response_body)
}

variable "tg_port" {
  default = "8080"
}