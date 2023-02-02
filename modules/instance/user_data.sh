#!/usr/bin/env bash
yum install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user
