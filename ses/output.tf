output "domain_identity" {
  value = aws_ses_domain_identity.this
}

output "domain_dkim" {
  value = aws_ses_domain_dkim.this
}

output "domain_mail" {
  value = aws_ses_domain_mail_from.this
}

output "ses_email_identity" {
  value = aws_ses_email_identity.this
}

output "route53record_this" {
  value = aws_route53_record.this
}

output "route53record_dkim_website" {
  value = aws_route53_record.dkim
}

output "route53record_bounce_website" {
  value = aws_route53_record.bounce
}

output "route53record_spf_website" {
  value = aws_route53_record.spf

}


