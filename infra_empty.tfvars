###############################
# VARIABLE DEFINITION 
###############################

# region
region = "eu-west-1"

# access credentials
aws_access_key = ""
aws_secret_key = ""
key_name = ""
private_key_path = ""


# variables for instance type and AMI
instance_type = "t2.micro"
image_id = "ami-04facb3ed127a2eb6"

# instance names
instance_name1 = "instance1"
instance_name2 = "instance2"
instance_name3 = "instance3"
instance_name4 = "instance4"
instance_name5 = "instance5"
instance_name6 = "instance6"
instance_name7 = "instance7"

# S3
bucket_name_prefix = "global"
billing_code_tag = "infra-deployment"
s3bucket_name = "infra-s3-bucket" 

# env tag
environment_tag = "infra"

# ELB
elb_name = "infra-elb"

# Availability zones
availability_zone1 = "eu-west-1a"
availability_zone2 = "eu-west-1b"
availability_zone3 = "eu-west-1c"


# network ranges for subnets per environment
merck_vpc_cidr = {
    Dev = "10.0.0.0/16"
    Uat = "10.1.0.0/16"
    Prod = "10.2.0.0/16"
    }

# number of subnets per environment
subnet_count = {
    Dev = 2
    Uat = 2
    Prod = 2
}

# type of EC2 based on environment
instance_size = {
    Dev = "t2.micro"
    Uat = "t2.micro"
    Prod = "t2.micro"
}

# BASTION VARIABLES
bastion_instance_type = "t2.micro"
bastion_instance_name = "infra_bastion_host"
bastion_az = "eu-west-1a"


# how many instances to create based on environment
instance_count = {
    Dev = 3
    Uat = 5
    Prod = 7
}
