output "ses_domain_identity" {
  value = aws_ses_domain_identity.this
}

output "ses_domain_dkim" {
  value = aws_ses_domain_dkim.this
}

output "ses_domain_mail_from" {
  value = aws_ses_domain_mail_from.this
}

output "ses_email_identity" {
  value = aws_ses_email_identity.this
}

output "route53_record_this" {
  value = aws_route53_record.this
}

output "route53_record_dkim" {
  value = aws_route53_record.dkim
}

output "route53_record_bounce" {
  value = aws_route53_record.bounce
}

output "route53_record_spf" {
  value = aws_route53_record.spf
}
