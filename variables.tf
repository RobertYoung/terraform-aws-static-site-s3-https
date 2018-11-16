variable "host_names" {
  type = "list"

  default = [
    "iamrobertyoung.co.uk",
    "me.iamrobertyoung.co.uk",
    "www.iamrobertyoung.co.uk",
  ]
}

variable "bucket_name" {
  default = "me.iamrobertyoung.co.uk"
}

variable "domain_name" {
  default = "iamrobertyoung.co.uk"
}

variable "certificate_domains" {
  type = "list"

  default = [
    "iamrobertyoung.co.uk",
    "*.iamrobertyoung.co.uk",
  ]
}
