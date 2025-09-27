module "s3" {
  source      = "./module/s3"
  bucket_name = var.bucket_name
}

module "cloudfront" {
  source          = "./module/cloudfront"
  host_names      = var.host_names
  bucket_name     = var.bucket_name
  domain_name     = module.s3.bucket_regional_domain_name
  certificate_arn = module.certificate-manager.certificate_arn
}

resource "aws_s3_bucket_policy" "cloudfront_oac" {
  bucket = module.s3.bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${module.s3.bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.cloudfront.distribution_arn
          }
        }
      }
    ]
  })
}

module "certificate-manager" {
  source                         = "./module/certificate-manager"
  additional_certificate_domains = var.additional_certificate_domains
  domain_name                    = var.domain_name
}

module "route53" {
  source             = "./module/route53"
  cloudfront_alias   = module.cloudfront.domain_name
  cloudfront_zone_id = module.cloudfront.hosted_zone_id
  domain_name        = var.domain_name
  host_names         = var.host_names
}
