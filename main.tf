terraform {
  backend "s3" {
    bucket = "hillel-devops-terraform-state-0120"
    key    = "lesson25/terraform/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "hillel-devops-terraform-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "alb" {
  source = "./modules/alb"

  name           = "react-alb"
  my_ip          = local.my_ip
  instance_ids   = [for host in module.my_host : host.instance_id]
  instance_sg_id = aws_security_group.my_host.id
}

module "my_host" {
  source = "./modules/instance"

  for_each = {
    first_instance : {
      instance_type : "t2.micro",
      root_block_size : 10,
      root_volume_type : "gp3"
    },
    second_instance : {
      instance_type : "t2.micro",
      root_block_size : 10,
      root_volume_type : "gp3"
    },
  }

  instance_name     = each.key
  instance_type     = each.value.instance_type
  root_block_size   = each.value.root_block_size
  root_volume_type  = lookup(each.value, "root_volume_type", "standard")
  instance_profile  = aws_iam_instance_profile.ecr_read_only.name
  security_group_id = aws_security_group.my_host.id

  depends_on = [aws_ecr_repository.react-app]
}

resource "aws_ecr_repository" "react-app" {
  name         = "react-realworld-app"
  force_delete = true

  provisioner "local-exec" {
    command = <<-EOF
rm -rf /tmp/app
git clone https://github.com/vladyslav-tripatkhi/react-redux-realworld-example-app.git /tmp/app
cd /tmp/app
docker build --platform linux/amd64 -t 058096277145.dkr.ecr.us-east-1.amazonaws.com/react-realworld-app:test .
aws ecr get-login-password | docker login --username AWS --password-stdin 058096277145.dkr.ecr.us-east-1.amazonaws.com
docker push 058096277145.dkr.ecr.us-east-1.amazonaws.com/react-realworld-app:test
EOF
  }
}
