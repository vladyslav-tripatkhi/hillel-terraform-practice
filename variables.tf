locals {
  my_ip = chomp(data.http.myip.response_body)
}