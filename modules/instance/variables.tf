variable "instance_name" {
  type        = string
  default     = "My Host"
  description = "My instance's name"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "My instance's name"
}

variable "root_block_size" {
  type        = number
  default     = null
  description = "description"
}

variable "root_volume_type" {
  type        = string
  default     = "gp2"
  description = "description"
}

variable "instance_profile" {
  type    = string
  default = null
}

variable "security_group_id" {
  type = string
}