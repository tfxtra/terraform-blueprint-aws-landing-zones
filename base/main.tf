locals {
  user   = split("@", var.admin_email)[0]
  domain = split("@", var.admin_email)[1]
}

resource "aws_organizations_organization" "this" {
    aws_service_access_principals = [
        "cloudtrail.amazonaws.com",
        "config.amazonaws.com",
        "sso.amazonaws.com"
    ]

    feature_set = "ALL"
}


resource "aws_organizations_organizational_unit" "workload" {
  name      = "workload"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "prod" {
  name      = "prod"
  parent_id = aws_organizations_organizational_unit.workload.id

  depends_on = [
    aws_organizations_organizational_unit.workload
  ]
}

resource "aws_organizations_account" "prod" {
  # A friendly name for the member account
  name  = "${var.project_name}-prod"
  email = "${local.user}+${var.project_name}-prod@${local.domain}"

  # Enables IAM users to access account billing information 
  # if they have the required permissions
  iam_user_access_to_billing = "DENY"

  parent_id = aws_organizations_organizational_unit.prod.id
}

resource "aws_organizations_account" "core" {
  # A friendly name for the member account
  name  = "${var.project_name}-core"
  email = "${local.user}+${var.project_name}-core@${local.domain}"

  # Enables IAM users to access account billing information 
  # if they have the required permissions
  iam_user_access_to_billing = "DENY"

  parent_id = aws_organizations_organizational_unit.workload.id
}