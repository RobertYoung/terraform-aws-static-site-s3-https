# Terraform AWS S3 Static Site + CloudFront + Route53

## What does this do?

- Creates an S3 bucket to store the static stie
- Sets up a CloudFront distribution pointing towards the S3 bucket
- Adds an A alias record in Route53 pointing towards CloudFront


## Getting Started

Update the variables in *variables.tf*.

Terraform assumes that the domain name has already been registered on Route53.

```sh
terraform init
terraform apply
```