##############################################################################
##### RESOURCE SECTION EC2 and S3 and IAM for S3 access ######################

resource "aws_instance" "infra_ec2" {
  count = var.instance_count[terraform.workspace]
  ami = var.image_id
  key_name = var.key_name
  instance_type = var.instance_size[terraform.workspace]
  vpc_security_group_ids = [aws_security_group.infra_ec2_sg.id]
  subnet_id = aws_subnet.infra_subnet[count.index % var.subnet_count[terraform.workspace]].id
  iam_instance_profile = aws_iam_instance_profile.infra_ec2_profile.name
  depends_on = [aws_iam_role_policy.infra_allow_s3_all]
  

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = file(var.private_key_path)
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo yum install telnet -y",
      "sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo",
      "sudo yum install docker-ce.x86_64 --nobest -y",
      "sudo yum install python3-pip.noarch -y",
      "sudo pip3.6 install docker-compose",
      "sudo pip3.6 install awscli",
      "sudo pip3.6 install s3cmd",
      "sudo yum install unzip -y",
      "sudo yum install gzip -y",
      "sudo service docker start",
      "sudo adduser chef_user",
      "sudo usermod -aG docker chef_user",
      "sudo docker pull httpd",
      "sudo docker pull nginx",
      "sudo yum install wget -y",
      "sudo curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip",
      "sudo unzip awscliv2.zip",
      "sudo ./aws/install",
      "sudo yum install git.x86_64 -y" 

    ]
  }
    tags = {
      Name = "${local.env_name}-${count.index + 1}-infra_ec2" 
    }
}


############   BASTION INSTANCE ############################################

resource "aws_instance" "infra_bastion_ec2" {
  count = 1
  ami = var.image_id
  key_name = var.key_name
  instance_type = var.instance_size[terraform.workspace]
  vpc_security_group_ids = [aws_security_group.infra_bastion_sg.id]
  subnet_id = aws_subnet.infra_subnet[count.index % var.subnet_count[terraform.workspace]].id

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = file(var.private_key_path)
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo yum install telnet -y",
      "sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo",
      "sudo yum install docker-ce.x86_64 --nobest -y",
      "sudo yum install python3-pip.noarch -y",
      "sudo pip3.6 install docker-compose",
      "sudo pip3.6 install awscli",
      "sudo pip3.6 install s3cmd",
      "sudo yum install unzip -y",
      "sudo yum install gzip -y",
      "sudo service docker start",
      "sudo adduser chef_user",
      "sudo usermod -aG docker chef_user",
      "sudo docker pull httpd",
      "sudo docker pull nginx",
      "sudo yum install wget -y",
      "sudo curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip",
      "sudo unzip awscliv2.zip",
      "sudo ./aws/install",
      "sudo yum install git.x86_64 -y" 
    ]
  }

    tags = {
      Name = var.bastion_instance_name
    }
}


# below structure #############################################################
# profile
### role
##### policy

########## INFRA EC2 profile ##################################################
### every instance will be sharing this profile ###############################
resource "aws_iam_instance_profile" "infra_ec2_profile" {
  name = "${local.env_name}-infra_ec2_profile"
  role = aws_iam_role.infra_allow_ec2_access_s3.name
}

###### ROLE DEFINITION ########################################################
resource "aws_iam_role" "infra_allow_ec2_access_s3" {
  name = "${local.env_name}infra_allow_ec2_access_s3"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
      "Effect": "Allow",
      "Sid": ""
      }
  ]
}
EOF
}

###### POLICY DEFINITION ######################################################
resource "aws_iam_role_policy" "infra_allow_s3_all" {
  name = "infra_allow_s3_all"
  role = aws_iam_role.infra_allow_ec2_access_s3.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}
EOF
}

#### S3 definition ###########################################################
resource "aws_s3_bucket" "infra_s3_bucket" {
  bucket = local.s3_bucket_name
  acl = "private"
  force_destroy = true
  tags = { 
    Name = local.s3_bucket_name 
    }
}


































