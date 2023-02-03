data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

data "aws_ec2_instance_type_offerings" "this" {
  filter {
    name   = "instance-type"
    values = var.supported_instance_types
  }

  location_type = "availability-zone-id"
}

data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "availability-zone-id"
    values = data.aws_ec2_instance_type_offerings.this.locations
  }
}