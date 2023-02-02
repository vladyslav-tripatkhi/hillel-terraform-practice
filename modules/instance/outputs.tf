output "instance_id" {
  value       = aws_instance.this.id
  description = "EC2 instance id"
  sensitive   = false
}

output "instance_ip" {
  value       = aws_instance.this.private_ip
  description = "EC2 instance id"
  sensitive   = false
}

output "module_path" {
  value = path.module
  sensitive = true
}