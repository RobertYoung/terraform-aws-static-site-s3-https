output "certificate_arn" {
  value = "${element(aws_acm_certificate_validation.default.*.certificate_arn, 0)}"
}
