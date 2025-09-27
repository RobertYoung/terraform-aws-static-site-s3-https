variable "cloudfront_alias" {
  type = string
}
variable "cloudfront_zone_id" {
  type = string
}
variable "domain_name" {
  type = string
}

variable "host_names" {
  type = list(string)
}
