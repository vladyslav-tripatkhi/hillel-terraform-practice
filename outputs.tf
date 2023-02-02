output "ten" {
  value       = "10"
  description = "description"
  sensitive   = false
}

# output "instance_ids" {
#   value = [for i in ["first_instance", "second_instance"] : module.my_host[i].instance_id]
#   sensitive = false
# }
