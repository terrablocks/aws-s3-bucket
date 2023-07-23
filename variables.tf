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

variable "policy" {
  type        = string
  default     = ""
  description = "Resource policy to apply to the S3 bucket. Leave it blank to generate one automatically"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Key Value pair to assign to the S3 bucket"
}
