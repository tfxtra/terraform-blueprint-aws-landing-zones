output "core_services_arn" {
  value = aws_organizations_account.core.arn
}

output "prod_arn" {
  value = aws_organizations_account.prod.arn
}