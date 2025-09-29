# Security Policy

## Supported Versions

We currently support the following versions with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

We take security vulnerabilities seriously. If you discover a security issue, please follow these steps:

### How to Report

1. **Do NOT** create a public GitHub issue for security vulnerabilities
2. Contact the repository owner directly
3. Include the following information:
   - Description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact assessment
   - Suggested fix (if available)

### Response Timeline

- **Initial Response**: Within 48 hours of report
- **Status Update**: Weekly updates on investigation progress
- **Resolution**: Security patches released as soon as possible

## Security Best Practices

### Infrastructure Security

- **S3 Bucket Access**: Private buckets with CloudFront Origin Access Control (OAC)
- **HTTPS Only**: All traffic encrypted via CloudFront SSL/TLS
- **Public Access Blocked**: S3 public access completely disabled
- **Versioning Enabled**: S3 object versioning for data protection

### Terraform Security

- **State File**: Store Terraform state in encrypted S3 backend (not included in this module)
- **Secrets**: Never commit AWS credentials or sensitive data to repository
- **IAM Permissions**: Follow principle of least privilege
- **Resource Tagging**: Tag resources for proper governance

### Recommended Actions

1. **Use AWS IAM roles** instead of access keys when possible
2. **Enable CloudTrail** for audit logging
3. **Set up AWS Config** for compliance monitoring
4. **Implement lifecycle policies** for cost optimization
5. **Regular security reviews** of deployed infrastructure

## Known Security Considerations

- This module creates internet-facing resources (CloudFront distribution)
- Certificate validation requires DNS control of the domain
- Route53 hosted zone creation affects DNS resolution

## Dependencies

Keep these dependencies updated for security patches:

- Terraform >= 1.5
- AWS Provider >= 5.0
- SSL certificates managed via AWS Certificate Manager

---

For questions about this security policy, please open a GitHub issue or contact the maintainers.
