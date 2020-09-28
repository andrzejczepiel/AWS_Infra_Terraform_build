##############################################################################
##### RESORUCE SECTION #######################################################

#### VPC ################################################
resource "aws_vpc" "infra_vpc" {
  cidr_block = var.infra_vpc_cidr[terraform.workspace]
  enable_dns_hostnames = "true"
  tags = {
    Name = "${local.env_name}-infra_vpc"
  }
}

#### INTERNET GATEWAY ###################################
resource "aws_internet_gateway" "infra_igw" {
    vpc_id = aws_vpc.infra_vpc.id
    tags = {
      Name = "${local.env_name}-infra_igw"
    }
}

#### SUBNET #############################################
resource "aws_subnet" "infra_subnet" {
  count = var.subnet_count[terraform.workspace]
  vpc_id = aws_vpc.infra_vpc.id
  cidr_block = cidrsubnet(var.infra_vpc_cidr[terraform.workspace], 8, count.index)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
 
  tags = { 
    Name = "${local.env_name}-infra_subnet-${count.index + 1}" 
    }
}



#### ROUTE TABLE ########################################
resource "aws_route_table" "infra_route_table" {
  vpc_id = aws_vpc.infra_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.infra_igw.id
  }
  tags = {
    Name = "${local.env_name}-infra_route_table"
  }
}

#### SUBNET AND ROUTE TABLE ASSOCIACTION ##################
resource "aws_route_table_association" "route_table_infra_subnet_association" {
  count = var.subnet_count[terraform.workspace]
  subnet_id      = aws_subnet.infra_subnet[count.index].id
  route_table_id = aws_route_table.infra_route_table.id
}