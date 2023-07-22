module "s3_bucket" {
  source = "github.com/terrablocks/aws-s3-bucket.git" # Always use `ref` to point module to a specific version or hash

  name = "example"
}
