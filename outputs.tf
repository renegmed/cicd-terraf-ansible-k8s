
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.main-vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.main-vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.main-vpc.public_subnets
}

output "ns-servers" {
  value = module.main-vpc.ns-servers
}
# output "kops_state_s3_bucker" {
#     value = module.k8s.kops_state_s3_bucker
# }
