provider "aws" {
  region = "us-east-1"
}

resource "aws_acm_certificate" "default" {
  domain_name = "${var.domain_name}"
  subject_alternative_names = "${var.certificate_domains}"
  validation_method         = "DNS"
}

data "aws_route53_zone" "external" {
  name = "${var.domain_name}"
}

resource "aws_route53_record" "validation" {
  zone_id = "${data.aws_route53_zone.external.zone_id}"
  ttl     = 60
  name = "${aws_acm_certificate.default.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.default.domain_validation_options.0.resource_record_type}"
  records = ["${aws_acm_certificate.default.domain_validation_options.0.resource_record_value}"]
}

resource "aws_acm_certificate_validation" "default" {
  count                   = "${length(var.certificate_domains)}"
  certificate_arn         = "${element(aws_acm_certificate.default.*.arn, count.index)}"
  validation_record_fqdns = ["${aws_route53_record.validation.*.fqdn}"]
}
