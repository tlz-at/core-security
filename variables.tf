# Kinesis Variables
variable "kinesis_s3_buffer_size" {
  description = "Buffer incoming data to the specified size, in MBs, before delivering it to the destination"
  default     = 5
}

variable "kinesis_s3_buffer_interval" {
  description = "Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination"
  default     = 300
}

variable "kinesis_s3_compression_format" {
  description = "The compression format; supports UNCOMPRESSED, GZIP, ZIP, or Snappy"
  default     = "GZIP"
}

# AWS Provider Vaiables
variable "region" {
  description = "AWS Region to deploy to"
  default     = "us-east-2"
}

variable "role_name" {
  description = "AWS role name to assume"
}

# Account Variables
variable "account_id" {
  description = "The ID of the working account"
}

variable "name" {
  description = "Name of the account"
}

variable "master_payer_account" {
  description = "AccountID of master_payer_account account"
}

variable "master_payer_org_id" {
  description = "org_id of the master-payer-account"
}

variable "region_secondary" {
  description = "secondary region to to configure vpc-flowlog-buckets"
  default     = "us-east-1"
}

variable "okta_provider_domain" {
  description = "The domain name of the IDP.  This is concatenated with the app name and should be in the format 'site.domain.tld' (no protocol or trailing /)."
}

variable "okta_app_id" {
  description = "The Okta app ID for SSO configuration."
}

variable "account_type" {
  description = "Account template type"
}

variable "tfe_host_name" {
  description = "host_name for ptfe"
}

variable "tfe_org_name" {
  description = "ptfe organization name"
}

variable "tfe_avm_workspace_name" {
  description = "Name of avm workspace"
}

variable "tfe_core_logging_workspace_name" {
  description = "Name of logging workspace"
}

variable "okta_token" {
  type = "string"
  description = "Okta API token (sensitive)"
}

variable "users_tlz_admin" {
  type        = "list"
  description = "list of user emails to provide access to this role (via okta)"
}
