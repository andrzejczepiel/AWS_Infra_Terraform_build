
##############################################################################
##### DATA SECTION ###########################################################

data "aws_ami" "linux" {
    most_recent = "true"
    owners = ["amazon"]
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }
}



###### list of avilability zones ######################################
data "aws_availability_zones" "available" {}