This build will create: 
VPC, Internet gateway, subnets, routing table, SG for ELB/EC2/Bastion host, EC2 instances, Profile, Role and S3 bucket policy, and S3 bucket.


Files included in this repository are used to build infrastructure in AWS based on EC2.
This build utilizes terraform workspace feature.
The idea is that you can use the same infra build to create different purpose environment eg: Dev, Uat, Prod etc.

In file infra_empty.vars specify your access data to AWS account. 

NOTE!!! in IAM create programatic account for this usage, or use external secret manager (eg. Vault) to store credentials.


Please also note mapping for Dev, Uat, Prod environments (change values if needed, number of instances etc)


run command:
  
    # terraform workspace list     

to create new workspace for example Dev  please run command:
  
    # terraform workspace new Dev

you can switch between workspaces using eg:
  
    # terraform workspace switch Prod
  
The tag which defines your workspace will be used as a tag when infra is build.

Validate your build:
  
    # terraform validate

Initialization:
  
    # terraform init

Create a plan with plan file name specific to your environment eg:
  
    # terraform plan -out infra_dev.ftplan -var-file="infra_empty.vars"
  
Apply plan:
  
    # terraform apply infra_dev.ftplan
