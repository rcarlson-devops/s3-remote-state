variable "region" {
  description = "AWS region for the state bucket"
  type        = string
  default     = "us-west-2"
}

variable "bucket_name_prefix" {
  description = "Prefix for the state bucket name (account ID is appended for uniqueness)"
  type        = string
  default     = "tfstate"
}