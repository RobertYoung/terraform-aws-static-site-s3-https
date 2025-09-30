# Contributing to Terraform AWS Static Site S3 HTTPS

Thank you for your interest in contributing to this Terraform module! This guide will help you get started with contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Environment](#development-environment)
- [Making Changes](#making-changes)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Release Process](#release-process)

## Code of Conduct

This project adheres to standard open source community guidelines. Please be respectful and constructive in all interactions.

## Getting Started

### Prerequisites

- **Terraform**: Version ~1.5 (as specified in our CI)
- **AWS CLI**: For testing (optional)
- **mise**: For tool version management (recommended)

### Repository Structure

```
├── main.tf                 # Main module composition
├── variables.tf            # Input variables
├── outputs.tf             # Output values
├── versions.tf            # Provider version constraints
├── providers.tf           # Provider configurations
└── modules/
    ├── certificate-manager/  # ACM certificate management
    ├── cloudfront/          # CloudFront distribution
    ├── route53/             # DNS records
    └── s3/                  # S3 bucket configuration
```

## Development Environment

### Using mise (Recommended)

This project uses `mise` for tool version management:

```bash
# Install mise if you haven't already
curl https://mise.run | sh

# Install project tools
mise install
```

### Manual Installation

If you prefer manual installation:

```bash
# Install Terraform
brew install terraform

# Install TFLint
brew install tflint

# Install Checkov
pip install checkov
```

## Making Changes

### 1. Fork and Clone

```bash
git clone https://github.com/your-username/terraform-aws-static-site-s3-https.git
cd terraform-aws-static-site-s3-https
```

### 2. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Code Style and Standards

- **Terraform Formatting**: All Terraform code must be formatted using `terraform fmt`
- **Variable Naming**: Use snake_case for variable names
- **Documentation**: Update variable descriptions and README as needed
  - The project uses terraform-docs to auto-generate documentation
  - Run `terraform-docs markdown table --recursive --output-file README.md --output-mode inject .` to update docs
  - Documentation is automatically validated in CI/CD
- **Security**: Follow AWS security best practices

### 4. Module Guidelines

When modifying modules:

- Keep modules focused on a single responsibility
- Use appropriate variable validation where possible
- Include meaningful descriptions for all variables and outputs
- Follow Terraform best practices for resource naming

## Testing

### Local Validation

Before submitting your changes, run the following checks locally:

```bash
# Format check
terraform fmt -check -recursive

# Initialize and validate
terraform init
terraform validate

# Run TFLint
tflint --init
tflint --recursive -f compact

# Run Checkov security scan
checkov

# Generate/update documentation
terraform-docs markdown table --recursive --output-file README.md --output-mode inject .
```

### Integration Testing

While this module doesn't include automated integration tests, please manually test your changes by:

1. Creating a test Terraform configuration that uses your modified module
2. Running `terraform plan` to verify the expected changes
3. If possible, apply the configuration to a test AWS environment

## Submitting Changes

### Pull Request Process

1. **Push your branch** to your fork
2. **Create a Pull Request** against the `main` branch
3. **Fill out the PR template** with:
   - Description of changes
   - Testing performed
   - Breaking changes (if any)

### PR Title Convention

This project validates PR titles. Use conventional commit format:

- `feat: add new feature`
- `fix: resolve bug`
- `docs: update documentation`
- `style: formatting changes`
- `refactor: code restructuring`
- `test: add or update tests`
- `chore: maintenance tasks`

### Automated Checks

Your PR will automatically trigger:

- **Terraform validation** and formatting checks
- **TFLint** static analysis
- **Security scanning** with various tools
- **Dependency review** for security vulnerabilities
- **PR title validation**

All checks must pass before merge.

### Review Process

- At least one maintainer review is required
- Address any feedback or requested changes
- Keep your PR up to date with the main branch

## Release Process

This project uses automated releases. When changes are merged to `main`:

1. A new release will be automatically created if appropriate
2. The version follows semantic versioning
3. Release notes are automatically generated

## Security

### Reporting Security Issues

Please report security vulnerabilities privately through GitHub's security advisory feature rather than opening public issues.

### Security Best Practices

- This module follows OpenSSF Best Practices
- Regular security scanning is performed via GitHub Actions
- Dependencies are monitored via Dependabot

## Questions or Help

- **Documentation**: Check the README.md for usage examples
- **Issues**: Open a GitHub issue for bugs or feature requests
- **Discussions**: Use GitHub Discussions for general questions

## Additional Resources

- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [OpenSSF Best Practices](https://bestpractices.coreinfrastructure.org/)

Thank you for contributing! 🎉
