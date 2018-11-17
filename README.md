# Terraform AWS S3 Static Site + CloudFront + Route53

## What does this do?

- Creates an S3 bucket to store the static stie
- Sets up a CloudFront distribution pointing towards the S3 bucket
- Adds an A alias record in Route53 pointing towards CloudFront


## Getting Started

Terraform assumes that the domain name has already been registered on Route53.

```sh
# CloudFront requires the certificate to be in us-east-1
provider "aws" {
  alias = "useast1"
  region = "us-east-1"
}

module "my-site" {
  source = "github.com/robertyoung/terraform-aws-static-site-s3-https"

  host_names = [
    "example.co.uk",
    "me.example.co.uk",
    "www.example.co.uk",
  ]

  bucket_name = "me.example.co.uk"

  domain_name = "example.co.uk"

  additional_certificate_domains = [
    "me.example.co.uk",
    "www.example.co.uk",
  ]
}
```