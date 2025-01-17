output "registry_instance" {
  value       = module.testbed.registry_instance
  description = "Information about the registry instance."
  sensitive   = true
}
output "proxy_instance" {
  value       = module.testbed.proxy_instance
  description = "Information about the proxy instance."
  sensitive   = true
}
output "bastion_instance" {
  value       = module.testbed.bastion_instance
  description = "Information about the bastion instance."
  sensitive   = true
}
output "vpc" {
  value       = module.testbed.vpc
  description = "Information about the provisioned VPC and its networks."
}
output "registry_bucket" {
  value       = module.testbed.registry_bucket
  sensitive   = true
  description = "The AWS S3 bucket for the registry and IAM credentials required to access it."
}
