variable "domain" {
  description = "ses domain identity, has to be listed as the domain"
  type        = string
}

variable "emails" {
  description = "ses email identity"
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "zone_id for the route 53 resource"
  type        = string
}

variable "bounce_mx_records" {
  description = "MX record for bound"
  type        = list(string)
  default = [
    "10 feedback-smtp.eu-west-2.amazonses.com"
  ]
}

variable "spf_txt_records" {
  description = "TXT record for SPF"
  type        = list(string)
  default = [
    "v=spf1 include:amazonses.com ~all"
  ]
}

variable "create_txt_record" {
  description = "Whether a txt record with domain identity verification token"
  type        = bool
  default     = true
}

variable "create_dkim_records" {
  description = "Whether a dkim record with tokens is created"
  type        = bool
  default     = true
}

variable "create_bounce_mx_records" {
  description = "Whether an MX record for bounce is created"
  type        = bool
  default     = true
}

variable "create_spf_txt_records" {
  description = "Whether a TXT record for SPF is created"
  type        = bool
  default     = true
}
