#!/usr/bin/env bash
yum install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user
aws ecr get-login-password \
--region=us-east-1 \
| docker login \
--username AWS \
--password-stdin 058096277145.dkr.ecr.us-east-1.amazonaws.com
docker run -d --name app -p 8080:80 058096277145.dkr.ecr.us-east-1.amazonaws.com/react-realworld-app:test
