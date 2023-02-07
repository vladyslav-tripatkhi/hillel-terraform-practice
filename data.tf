data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}