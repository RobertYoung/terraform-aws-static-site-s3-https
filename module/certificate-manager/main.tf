provider "aws" {
  region = "us-east-1"
}

resource "aws_acm_certificate" "default" {
  count             = "${length(var.certificate_domains)}"
  domain_name       = "${element(var.certificate_domains, count.index)}"
  validation_method = "DNS"
}

data "aws_route53_zone" "external" {
  name = "${var.domain_name}"
}

locals {
  dvo = "${flatten(aws_acm_certificate.default.*.domain_validation_options)}"
}

resource "aws_route53_record" "validation" {

  count   = "${length(var.certificate_domains)}"
  zone_id = "${data.aws_route53_zone.external.zone_id}"
  ttl     = 60

  name    = "${lookup(local.dvo[count.index], "resource_record_name")}"
  type    = "${lookup(local.dvo[count.index], "resource_record_type")}"
  records = ["${lookup(local.dvo[count.index], "resource_record_value")}"]
}

resource "aws_acm_certificate_validation" "default" {
  count                   = "${length(var.certificate_domains)}"
  certificate_arn         = "${element(aws_acm_certificate.default.*.arn, count.index)}"
  validation_record_fqdns = ["${aws_route53_record.validation.*.fqdn}"]
}
