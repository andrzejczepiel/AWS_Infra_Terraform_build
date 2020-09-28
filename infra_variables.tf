##############################################################################
#### VARIABLE SECTION ########################################################
#### declare here all your variables #########################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "key_name" {}
variable "private_key_path" {}
variable "instance_type" {}
variable "image_id" {}

variable "instance_name1" {}
variable "instance_name2" {}
variable "instance_name3" {}
variable "instance_name4" {}
variable "instance_name5" {}
variable "instance_name6" {}
variable "instance_name7" {}

variable "region" { default = "eu-west-1" }

variable "availability_zone1" {}
variable "availability_zone2" {}
variable "availability_zone3" {}

# adding S3 bucket service
variable "bucket_name_prefix" {}
variable "billing_code_tag" {}
variable "environment_tag" {}
variable "s3bucket_name" {}

# bastion variables
variable "bastion_instance_type" {}
variable "bastion_instance_name" {}
variable "bastion_az" {}



# ELB
variable "elb_name" {}

# INFRA VPC
variable "infra_vpc_cidr" {
  type = map(string)
  }

# subnet count
variable "subnet_count" {
  type = map(number)
  }

# instance size
variable "instance_size" {
  type = map(string)
  }

# instance count
variable "instance_count" {
  type = map(number)
  }
