# -------------------------------------------------------------------------------------------------
# SES validation for domains and emails.

This terraform module could be useful for when a user would like to build a validation method in order to
validate domains and emails through the use of resources such as SES's and Route 53 records.
# -------------------------------------------------------------------------------------------------
```terraform
provider "aws" {
  version = "3.4.0"
  region  = "eu-west-2"

}


### - Creates a domain
resource "aws_ses_domain_identity" "this" {
domain = var.domain
}

### - Creates the dkim domian
resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

### - Creates the mail domain
resource "aws_ses_domain_mail_from" "this" {
  domain           = aws_ses_domain_identity.this.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.this.domain}"
}

### - Resource for emails to be created
resource "aws_ses_email_identity" "this" {
email = var.email
}

resource "aws_route53_record" "this" {
  zone_id = var.zone_id //main zone_id
  name    = var.domain
  type    = "TXT"
  ttl     = "60"
  records = [aws_ses_domain_identity.this.verification_token
  ]

}

resource "aws_route53_record" "dkim" {
  count   = 3
  zone_id = var.zone_id // the zone_id's should link up to the 'main' zone_id
  name    = "${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}.dkim.amazonses.com"
  ]
}

resource "aws_route53_record" "bounce" {
  zone_id = var.zone_id // the zone_id's should link up to the 'main' zone_id
  name    = aws_ses_domain_mail_from.this.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = [
    "10 feedback-smtp.eu-west-2.amazonses.com"
  ]
}

resource "aws_route53_record" "spf" {
  zone_id = var.zone_id // the zone_id's should link up to the 'main' zone_id
  name    = aws_ses_domain_mail_from.this.mail_from_domain
  type    = "TXT"
  ttl     = "300"
  records = [
    "v=spf1 include:amazonses.com ~all"
  ]
}
```
