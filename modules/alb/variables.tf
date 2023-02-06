variable "name" {
  type        = string
  description = "description"
}

variable "supported_instance_types" {
  type    = list(string)
  default = ["t2.micro"]
}

variable "my_ip" {
  type = string
}

variable "instance_ids" {
  type    = list(string)
  default = []
}

variable "instance_sg_id" {
  type = string
}

variable "tg_port" {
  default = "8080"
}

variable "listener_port" {
  default = "8001"
}