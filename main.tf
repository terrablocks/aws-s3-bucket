resource "aws_s3_bucket" "this" {
  # checkov:skip=CKV_AWS_18: Access logging can be enabled by user if needed
  # checkov:skip=CKV_AWS_144: CRR can be enabled by user if needed
  # checkov:skip=CKV_AWS_21: Versioning can be enabled by user if needed
  # checkov:skip=CKV_AWS_145: SSE encrytion depends on user
  # checkov:skip=CKV_AWS_19: SSE encrytion depends on user
  # checkov:skip=CKV_AWS_52: MFA delete can be enabled by user if needed
  # checkov:skip=CKV2_AWS_62: Event notification can be enabled by user if needed
  # checkov:skip=CKV2_AWS_61: Enabling lifecycle configuration depends on user
  bucket              = var.name
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags                = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status     = var.disable_versioning ? "Disabled" : (var.suspend_versioning ? "Suspended" : "Enabled")
    mfa_delete = var.enable_mfa_delete ? "Enabled" : "Disabled"
  }

  mfa = var.mfa
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.object_ownership
  }
}

data "aws_kms_key" "this" {
  key_id = var.kms_key
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key == "alias/aws/s3" ? "AES256" : "aws:kms"
      kms_master_key_id = var.kms_key == "alias/aws/s3" ? null : data.aws_kms_key.this.arn
    }

    bucket_key_enabled = var.bucket_key_enabled
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.apply_ssl_deny_policy ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSSLRequestsOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
          NumericLessThan = {
            "s3:TlsVersion" = "1.2"
          }
        }
      }
    ]
  })
}
