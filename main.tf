data "aws_caller_identity" "current" {}

module "tfstate_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.16"

  bucket = "${var.bucket_name_prefix}-${data.aws_caller_identity.current.account_id}-${var.region}"

  # Never let `terraform destroy` wipe your state history
  force_destroy = false

  # Versioning lets you recover from a bad or corrupted state file
  versioning = {
    enabled = true
  }

  # Encryption at rest
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  # Keep it private
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  # Deny non-TLS access and TLS < 1.2
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  tags = {
    Purpose   = "terraform-remote-state"
    ManagedBy = "terraform"
  }
}