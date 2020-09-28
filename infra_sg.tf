
####################  EC2 security group ##################
resource "aws_security_group" "infra_ec2_sg" {
  name = "infra_ec2_sg"
  description = "allow ssh access to EC2"
  vpc_id = aws_vpc.infra_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    #cidr_blocks = [var.infra_vpc_cidr]
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

####################  ELB security group ##################
resource "aws_security_group" "infra_elb_sg" {
  name = "infra_elb_sg"
  description = "web access to infraelb"
  vpc_id = aws_vpc.infra_vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



####################  Bastion security group ##################
resource "aws_security_group" "infra_bastion_sg" {
  name = "infra_bastion_sg"
  description = "SSH access to EC2 instances in infra"
  vpc_id = aws_vpc.infra_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}