variable "host_names" {
  type = "list"

  default = [
    "example.com",
    "me.example.com",
    "www.example.com",
  ]
}

variable "bucket_name" {
  default = "me.example.com"
}

variable "domain_name" {
  default = "example.com"
}

variable "additional_certificate_domains" {
  type = "list"

  default = [
    "me.example.com",
    "www.example.com",
  ]
}