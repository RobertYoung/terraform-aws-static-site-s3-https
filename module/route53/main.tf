data "aws_route53_zone" "external" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  count   = length(var.host_names)
  zone_id = data.aws_route53_zone.external.zone_id
  name    = element(var.host_names, count.index)
  type    = "A"

  alias {
    name                   = var.cloudfront_alias
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}
