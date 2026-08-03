output "certificate_arn" {
  value = aws_acm_certificate_validation.default[0].certificate_arn
}
