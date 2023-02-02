data "aws_ami" "awslinux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

data "local_file" "user_data" {
  filename = "${path.module}/user_data.sh"
} 