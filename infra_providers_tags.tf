##############################################################################
####  PROVIDER SECTION #######################################################

provider "aws" {
  region  = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  version = "~> 2.49"
}


##############################################################################
### TAGS used by all resources in infra

locals {
  common_tag = "${var.billing_code_tag}-${var.environment_tag}"
  env_name = lower(terraform.workspace)
  Environment = local.env_name
  s3_bucket_name = "${var.bucket_name_prefix}-${local.env_name}-${local.common_tag}"
}


