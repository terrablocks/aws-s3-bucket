variable "name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "force_destroy" {
  type        = bool
  default     = true
  description = "Empty bucket contents before deleting S3 bucket"
}

variable "object_lock_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable object lock configuration for the bucket. **Note:** This argument is not supported for all regions or partitions"
}

variable "disable_versioning" {
  type        = bool
  default     = true
  description = "Whether to disable bucket versioning (should only be used when creating or importing resources that correspond to unversioned S3 buckets)"
}

variable "suspend_versioning" {
  type        = bool
  default     = false
  description = "Whether to suspend the bucket versioning"
}

variable "object_ownership" {
  type        = string
  default     = "BucketOwnerEnforced"
  description = "Specify object ownership method. Possible values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
}

variable "kms_key" {
  type        = string
  default     = "alias/aws/s3"
  description = "Alias/ARN/ID of KMS key for S3 SSE encryption"
}

variable "bucket_key_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable [bucket level keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html) for rest-side encryption"
}

variable "enable_mfa_delete" {
  type        = bool
  default     = false
  description = "Enable MFA delete for S3 bucket"
}

variable "mfa" {
  type        = string
  default     = null
  description = "The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device. **Note:** Required only if `enable_mfa_delete` is set to true"
}

variable "block_public_acls" {
  type        = bool
  default     = true
  description = "Whether to block creation of public ACLs"
}

variable "block_public_policy" {
  type        = bool
  default     = true
  description = "Whether to allow attaching bucket policy that makes the entire bucket contents accessible to public"
}

variable "ignore_public_acls" {
  type        = bool
  default     = true
  description = "Whether to ignore existing public ACLs for the bucket"
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Whether to ignore existing public bucket policy and make the bucket accessible only for owner"
}

variable "apply_ssl_deny_policy" {
  type        = bool
  default     = true
  description = "Apply the default [SSL deny policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies.html#example-bucket-policies-HTTP-HTTPS) to the S3 bucket. **Note:** Set this to false if you want to attach your own policy"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Key Value pair to assign to the S3 bucket"
}
