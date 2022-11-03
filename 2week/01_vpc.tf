provider "aws" {
  region  = "ap-northeast-2"
}

resource "aws_vpc" "dh-vpc" {
  cidr_block       = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "t101-study"
  }
}

resource "aws_subnet" "dh-subnet1" {
  vpc_id     = aws_vpc.dh-vpc.id
  cidr_block = "10.10.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "t101-subnet1"
  }
}

resource "aws_subnet" "dh-subnet2" {
  vpc_id     = aws_vpc.dh-vpc.id
  cidr_block = "10.10.2.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "t101-subnet2"
  }
}


resource "aws_internet_gateway" "dh-igw" {
  vpc_id = aws_vpc.dh-vpc.id

  tags = {
    Name = "t101-igw"
  }
}

resource "aws_route_table" "dh-rt" {
  vpc_id = aws_vpc.dh-vpc.id

  tags = {
    Name = "t101-rt"
  }
}

resource "aws_route_table_association" "dh-rtassociation1" {
  subnet_id      = aws_subnet.dh-subnet1.id
  route_table_id = aws_route_table.dh-rt.id
}

resource "aws_route_table_association" "dh-rtassociation2" {
  subnet_id      = aws_subnet.dh-subnet2.id
  route_table_id = aws_route_table.dh-rt.id
}

resource "aws_route" "dh-defaultroute" {
  route_table_id         = aws_route_table.dh-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dh-igw.id
}

