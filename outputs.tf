output "state_bucket_name" {
  value = module.tfstate_bucket.s3_bucket_id
}

output "state_bucket_arn" {
  value = module.tfstate_bucket.s3_bucket_arn
}

output "state_bucket_region" {
  value = module.tfstate_bucket.s3_bucket_region
}
