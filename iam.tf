resource "aws_iam_role" "ecr_read_only" {
  name = "ecr-read-only"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": "AllowEc2ToAssumeThisRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecr_read_only" {
  role       = aws_iam_role.ecr_read_only.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ecr_read_only" {
  name = "ecr-read-only"
  role = aws_iam_role.ecr_read_only.name
}