data "aws_route53_zone" "external" {
  name = "${var.domain_name}"
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.external.zone_id}"
  name    = "${var.host_name}"
  type    = "A"

  alias {
    name                   = "${var.cloudfront_alias}"
    zone_id                = "${var.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}
