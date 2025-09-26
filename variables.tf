variable "host_names" {
  type = list(string)

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
  type = list(string)

  default = [
    "me.example.com",
    "www.example.com",
  ]
}
