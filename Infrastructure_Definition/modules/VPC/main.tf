# Creating VPC
resource "aws_vpc" "demoVpc" {
  cidr_block           = var.vpcCIDR
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.projectName}-vpc"
    Env  = var.env
    Type = var.type
  }
}

# Creating Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "demoInternetGateway" {
  vpc_id = aws_vpc.demoVpc.id

  tags = {
    Name = "${var.projectName}-igw"
    Env  = var.env
    Type = var.type
  }
}

# Using data source to get all Avalablility Zones in region
data "aws_availability_zones" "availableZones" {}

# Creating Public Subnet in AZ1
resource "aws_subnet" "publicSubnetAz1" {
  vpc_id                  = aws_vpc.demoVpc.id
  cidr_block              = var.publicSubnetAz1CIDR
  availability_zone       = data.aws_availability_zones.availableZones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet AZ1"
    Env  = var.env
    Type = var.type
  }
}

# Creating Public Subnet in AZ2
resource "aws_subnet" "publicSubnetAz2" {
  vpc_id                  = aws_vpc.demoVpc.id
  cidr_block              = var.publicSubnetAz2CIDR
  availability_zone       = data.aws_availability_zones.availableZones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet AZ2"
    Env  = var.env
    Type = var.type
  }
}

# Creating Public Subnet in AZ3
resource "aws_subnet" "publicSubnetAz3" {
  vpc_id                  = aws_vpc.demoVpc.id
  cidr_block              = var.publicSubnetAz3CIDR
  availability_zone       = data.aws_availability_zones.availableZones.names[2]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet AZ3"
    Env  = var.env
    Type = var.type
  }
}

# Creating Route Table and add Public Route
resource "aws_route_table" "publicRouteTable" {
  vpc_id = aws_vpc.demoVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demoInternetGateway.id
  }

  tags = {
    Name = "Public Route Table"
    Env  = var.env
    Type = var.type
  }
}

# Associating Public Subnet in AZ1 to route table
resource "aws_route_table_association" "publicSubnetAz1RouteTableAssociation" {
  subnet_id      = aws_subnet.publicSubnetAz1.id
  route_table_id = aws_route_table.publicRouteTable.id
}

# Associating Public Subnet in AZ2 to route table
resource "aws_route_table_association" "publicSubnetAz2RouteTableAssociation" {
  subnet_id      = aws_subnet.publicSubnetAz2.id
  route_table_id = aws_route_table.publicRouteTable.id
}

# Associating Public Subnet in AZ3 to route table
resource "aws_route_table_association" "publicSubnetAz3RouteTableAssociation" {
  subnet_id      = aws_subnet.publicSubnetAz3.id
  route_table_id = aws_route_table.publicRouteTable.id
}

# Creating NACL
resource "aws_network_acl" "demoNACL" {
  vpc_id = aws_vpc.demoVpc.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}