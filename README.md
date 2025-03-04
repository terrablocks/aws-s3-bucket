<!-- BEGIN_TF_DOCS -->
# Create a secured S3 Bucket

![License](https://img.shields.io/github/license/terrablocks/aws-s3-bucket?style=for-the-badge) ![Plan](https://img.shields.io/github/actions/workflow/status/terrablocks/aws-s3-bucket/tf-plan.yml?branch=main&label=Plan&style=for-the-badge) ![Checkov](https://img.shields.io/github/actions/workflow/status/terrablocks/aws-s3-bucket/checkov.yml?branch=main&label=Checkov&style=for-the-badge) ![Commit](https://img.shields.io/github/last-commit/terrablocks/aws-s3-bucket?style=for-the-badge) ![Release](https://img.shields.io/github/v/release/terrablocks/aws-s3-bucket?style=for-the-badge)

This terraform module will deploy the following services:
- S3 Bucket

# Usage Instructions
## Example
```hcl
module "s3_bucket" {
  source = "github.com/terrablocks/aws-s3-bucket.git" # Always use `ref` to point module to a specific version or hash

  name = "example"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| aws | >= 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apply_ssl_deny_policy | Apply the default [SSL deny policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies.html#example-bucket-policies-HTTP-HTTPS) to the S3 bucket. Set this to false if you want to attach your own policy | `bool` | `true` | no |
| block_public_acls | Whether to block creation of public ACLs | `bool` | `true` | no |
| block_public_policy | Whether to allow attaching bucket policy that makes the entire bucket contents accessible to public | `bool` | `true` | no |
| bucket_key_enabled | Whether to use [Amazon S3 Bucket keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html) for rest-side encryption | `bool` | `true` | no |
| force_destroy | Empty bucket contents before deleting S3 bucket | `bool` | `true` | no |
| ignore_public_acls | Whether to ignore existing public ACLs for the bucket | `bool` | `true` | no |
| kms_key | Alias/ARN/ID of KMS key for S3 SSE encryption | `string` | `"alias/aws/s3"` | no |
| name | Name of the S3 bucket | `string` | n/a | yes |
| object_lock_enabled | Whether to enable object lock configuration for the bucket. **Note:** This argument is not supported for all regions or partitions | `bool` | `false` | no |
| object_ownership | Specify object ownership method. Possible values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced | `string` | `"BucketOwnerEnforced"` | no |
| restrict_public_buckets | Whether to ignore existing public bucket policy and make the bucket accessible only for owner | `bool` | `true` | no |
| tags | Key Value pair to assign to the S3 bucket | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN of the S3 bucket |
| hosted_zone_id | Route53 hosted zone id for the S3 bucket |
| name | Name of the S3 bucket |
| region | Region the S3 bucket is hosted in |
| regional_domain_name | Region specific domain name of the bucket |

<!-- END_TF_DOCS -->
