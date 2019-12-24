# Connect to the core-logging account to get S3 buckets
data "terraform_remote_state" "logging" {
  backend = "remote"

  config {
    organization = "${var.tfe_org_name}"
    hostname     = "${var.tfe_host_name}"

    workspaces {
      name = "${var.tfe_core_logging_workspace_name}"
    }
  }
}
locals {
  firehose_guardduty_role_arn = "${data.terraform_remote_state.logging.guardduty_firehose_role_arn}"
  s3_guardduty_logs_bucket_arn  = "${data.terraform_remote_state.logging.s3_guardduty_logs_bucket_arn}"
}

module "account-baseline" {
  source                 = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws"
  version                = "~> 0.2.15"
  account_name           = "${var.name}"
  account_type           = "${var.account_type}"
  account_id             = "${var.account_id}"
  okta_provider_domain   = "${var.okta_provider_domain}"
  okta_app_id            = "${var.okta_app_id}"
  region                 = "${var.region}"
  region_secondary       = "${var.region_secondary}"
  role_name              = "${var.role_name}"
  config_logs_bucket     = "${data.terraform_remote_state.logging.s3_config_logs_bucket_name}"
  tfe_host_name          = "${var.tfe_host_name}"
  tfe_org_name           = "${var.tfe_org_name}"
  tfe_avm_workspace_name = "${var.tfe_avm_workspace_name}"
  okta_environment       = "${substr(var.account_type, 0, 3)}"
}

module "tlz_admin" {
  source                = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws//modules/iam-tlz_admin"
  version               = "~> 0.2.15"
  okta_provider_arn     = "${module.account-baseline.okta_provider_arn}"
  deny_policy_arns      = "${module.account-baseline.deny_policy_arns}"
}

# module "tlz_admin_okta" {
#   source           = "app.terraform.io/blizzard-cloud/tlz_group_membership_manager/okta"
#   aws_account_id   = "${var.account_id}"
#   okta_hostname    = "${var.okta_provider_domain}"
#   tlz_account_type = "${var.account_type}"
#   user_emails      = ["${var.users_tlz_admin}"]
#   api_token        = "${var.okta_token}"
#   role_name        = "tlz_admin"
# }

#TODO: Cirrus-630 needs to hook in with okta to provide actual access. Both SecOps and IR roles
module "tlz_security_ir" {
  source                  = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws//modules/iam-policy-securityir"
  version                 = "~> 0.2.15"
  okta_provider_arn       = "${module.account-baseline.okta_provider_arn}"
}
