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

