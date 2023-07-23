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
      kms_master_key_id = var.kms_key == "alias/aws/s3" ? null : data.aws_kms_key.this.id
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid     = "AllowSSLRequestsOnly"
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = var.policy == "" ? data.aws_iam_policy_document.bucket_policy.json : var.policy
}
