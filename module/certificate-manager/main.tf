provider "aws" {
  region = "us-east-1"
}

data "aws_route53_zone" "external" {
  name = "${var.domain_name}"
}

resource "aws_acm_certificate" "default" {
  domain_name = "${var.domain_name}"
  subject_alternative_names = "${var.additional_certificate_domains}"
  validation_method         = "DNS"
}

locals {	
  dvo = "${flatten(aws_acm_certificate.default.*.domain_validation_options)}"	
}

resource "aws_route53_record" "validation" {
  count   = "${length(var.additional_certificate_domains) + 1}"
  zone_id = "${data.aws_route53_zone.external.zone_id}"
  ttl     = 60
  name    = "${lookup(local.dvo[count.index], "resource_record_name")}"
  type    = "${lookup(local.dvo[count.index], "resource_record_type")}"
  records = ["${lookup(local.dvo[count.index], "resource_record_value")}"]
}

resource "aws_acm_certificate_validation" "default" {
  count                   = "${length(var.additional_certificate_domains)}"
  certificate_arn         = "${element(aws_acm_certificate.default.*.arn, count.index)}"
  validation_record_fqdns = ["${aws_route53_record.validation.*.fqdn}"]
}
