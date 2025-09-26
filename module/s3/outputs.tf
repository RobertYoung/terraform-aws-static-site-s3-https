output "arn" {
  value = aws_s3_bucket.site.arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.site.bucket_regional_domain_name
}
