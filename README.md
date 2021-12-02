# SES validation for domains and emails.

Terraform module to create SES domain with DKIM and SPF validation.
Optionally accepts email addresses to validate if AWS account is in sandbox for email sending.

## Examples

### Create all resources
Assuming a zone has already been created.

```terraform
provider "aws" {
  version = "3.4.0"
  region  = "eu-west-2"
}

module "example1" {
  source  = "voquis/ses-validated-domain-and-emails/aws"
  version = "0.0.2"
  zone_id = aws_route53_zone.example.zone_id
  domain  = aws_route53_zone.example.name
  emails  = [
    "user1@example.com",
    "user2@example.com",
  ]
}
```

### Create txt records externally
This example is useful when an existing `TXT` record already exists and

```terraform
provider "aws" {
  version = "3.4.0"
  region  = "eu-west-2"
}

module "example1" {
  source  = "voquis/ses-validated-domain-and-emails/aws"
  version = "0.0.2"
  zone_id = aws_route53_zone.example.zone_id
  domain  = aws_route53_zone.example.name
}

resource "aws_route53_record" "txt_example" {
  zone_id = aws_route53_zone.example.id
  name    = ""
  type    = "TXT"
  ttl     = "300"
  records = [
    "existing-value-1",
    "existing-value-2",
    module.example.ses_domain_identity.verification_token
  ]
}
```
