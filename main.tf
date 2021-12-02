# -------------------------------------------------------------------------------------------------
# SES Resources
# -------------------------------------------------------------------------------------------------

resource "aws_ses_domain_identity" "this" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

resource "aws_ses_domain_mail_from" "this" {
  domain           = aws_ses_domain_identity.this.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.this.domain}"
}

resource "aws_ses_email_identity" "this" {
  count = length(var.emails)
  email = var.emails[count.index]
}

# ------------------------------------------------------------------------------------------------
# Route 53 resources for SES
# -------------------------------------------------------------------------------------------------
resource "aws_route53_record" "this" {
  count   = var.create_txt_record ? 1 : 0
  zone_id = var.zone_id
  name    = var.domain
  type    = "TXT"
  ttl     = "60"
  records = [
    aws_ses_domain_identity.this.verification_token
  ]
}

resource "aws_route53_record" "dkim" {
  count   = var.create_dkim_records ? 3 : 0
  zone_id = var.zone_id
  name    = "${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = [
    "${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}.dkim.amazonses.com"
  ]
}

resource "aws_route53_record" "bounce" {
  count   = var.create_bounce_mx_records ? 1 : 0
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.this.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = var.bounce_mx_records
}

resource "aws_route53_record" "spf" {
  count   = var.create_spf_txt_records ? 1 : 0
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.this.mail_from_domain
  type    = "TXT"
  ttl     = "300"
  records = var.spf_txt_records
}
