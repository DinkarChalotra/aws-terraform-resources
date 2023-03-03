resource "aws_vpc" "example_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.name_prefix
  }
}

resource "aws_internet_gateway" "example_internet_gateway" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name = var.name_prefix
  }
}

resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_internet_gateway.id
  }
  tags = {
    Name = var.name_prefix
  }
}

resource "aws_route_table_association" "example_route_table_association" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.example_route_table.id
}

resource "aws_subnet" "example_public_subnet" {
  vpc_id = aws_vpc.example_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.name_prefix}-public"
  }
}

variable "name_prefix" {
  type        = string
  description = "The prefix to use for the name of the VPC, the Internet Gateway, the Route Table, and the Subnet."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "The CIDR block for the public subnet."
}

variable "public_subnet_id" {
  type        = string
  description = "The ID of the public subnet to associate with the route table."
}

variable "availability_zone" {
  type        = string
  description = "The availability zone in which to create the public subnet."
}
