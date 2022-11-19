data "tfe_workspace" "lz" {
  organization = var.org_name
  name = "aws-landing-zones"
}

resource "tfe_variable" "access_key" {
  key          = "aws_access_key"
  value        = aws_iam_access_key.terraform.id
  category     = "terraform"
  workspace_id = data.tfe_workspace.lz.id
  description  = "AWS Access Key ID"
}

resource "tfe_variable" "secret_key" {
  key          = "aws_secret_key"
  value        = aws_iam_access_key.terraform.secret
  category     = "terraform"
  workspace_id = data.tfe_workspace.lz.id
  description  = "AWS Access Key ID"
}

resource "tfe_variable" "region" {
  key          = "region"
  value        = var.region
  category     = "terraform"
  workspace_id = data.tfe_workspace.lz.id
  description  = "Region to deploy to"
}

resource "tfe_variable" "admin_email" {
  key          = "admin_email"
  value        = var.admin_email
  category     = "terraform"
  workspace_id = data.tfe_workspace.lz.id
  description  = "Admin email for AWS account"
}

resource "tfe_variable" "project_name" {
  key          = "project_name"
  value        = var.project_name
  category     = "terraform"
  workspace_id = data.tfe_workspace.lz.id
  description  = "Name of project within AWS"
}
