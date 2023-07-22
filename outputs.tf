output "name" {
  value       = aws_s3_bucket.this.id
  description = "Name of the S3 bucket"
}

output "arn" {
  value       = aws_s3_bucket.this.arn
  description = "ARN of the S3 bucket"
}

output "region" {
  value       = aws_s3_bucket.this.region
  description = "Region the S3 bucket is hosted in"
}

output "hosted_zone_id" {
  value       = aws_s3_bucket.this.hosted_zone_id
  description = "Route53 hosted zone id for the S3 bucket"
}

output "regional_domain_name" {
  value       = aws_s3_bucket.this.bucket_regional_domain_name
  description = "Region specific domain name of the bucket"
}
