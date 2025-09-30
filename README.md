# Terraform AWS S3 Static Site + CloudFront + Route53

[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/11246/badge)](https://www.bestpractices.dev/projects/11246)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/RobertYoung/terraform-aws-static-site-s3-https/badge)](https://securityscorecards.dev/viewer/?uri=github.com/RobertYoung/terraform-aws-static-site-s3-https)
[![Release](https://github.com/RobertYoung/terraform-aws-static-site-s3-https/actions/workflows/release.yml/badge.svg)](https://github.com/RobertYoung/terraform-aws-static-site-s3-https/actions/workflows/release.yml)
[![Dependabot Updates](https://github.com/RobertYoung/terraform-aws-static-site-s3-https/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/RobertYoung/terraform-aws-static-site-s3-https/actions/workflows/dependabot/dependabot-updates)

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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.14.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_certificate-manager"></a> [certificate-manager](#module\_certificate-manager) | ./modules/certificate-manager | n/a |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./modules/cloudfront | n/a |
| <a name="module_route53"></a> [route53](#module\_route53) | ./modules/route53 | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_policy.cloudfront_oac](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_certificate_domains"></a> [additional\_certificate\_domains](#input\_additional\_certificate\_domains) | n/a | `list(string)` | <pre>[<br/>  "me.example.com",<br/>  "www.example.com"<br/>]</pre> | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | `"me.example.com"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `"example.com"` | no |
| <a name="input_host_names"></a> [host\_names](#input\_host\_names) | n/a | `list(string)` | <pre>[<br/>  "example.com",<br/>  "me.example.com",<br/>  "www.example.com"<br/>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Contributing

We welcome contributions! Please follow these guidelines:

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [terraform-docs](https://terraform-docs.io/user-guide/installation/) for documentation generation
- [TFLint](https://github.com/terraform-linters/tflint) for linting
- [Checkov](https://www.checkov.io/2.Basics/Installing%20Checkov.html) for security scanning

### Development Workflow

1. **Fork and clone** the repository
2. **Create a feature branch** from `main`
3. **Make your changes** following our coding standards
4. **Update documentation** (see below)
5. **Run tests and linting** (see below)
6. **Submit a pull request**

### Documentation Generation

This project uses terraform-docs to automatically generate documentation. The configuration is defined in `.terraform-docs.yml`.

To update the documentation:

```bash
terraform-docs .
```

Or manually with full parameters:

```bash
terraform-docs markdown table --recursive --output-file README.md --output-mode inject .
```

### Testing and Validation

Before submitting a PR, please run:

```bash
# Format check
terraform fmt -check -recursive

# Initialize and validate
terraform init
terraform validate

# Lint with TFLint
tflint --init
tflint --recursive -f compact

# Security scanning
checkov
```

### Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/) for automated versioning:

- `feat:` - New features (minor release)
- `fix:` - Bug fixes (patch release)
- `feat!:` or `BREAKING CHANGE:` - Breaking changes (major release)
- `docs:` - Documentation updates
- `ci:` - CI/CD changes
- `chore:` - Maintenance tasks

### Pull Request Guidelines

- Use descriptive titles and descriptions
- Reference any related issues
- Ensure all CI checks pass
- Update documentation if needed
- Add tests for new functionality
