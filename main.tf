terraform {
  required_version = ">= 0.12"
  experiments = [variable_validation]
}

provider "aws" {
  region = var.aws_region
}

# Create a VPC for all our resources
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  tags = {
    contact = "j-mark"
    env = "dev"
    service = "cart:search"
  }
}

# Create an internet gateway for outside access
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    contact = "j-mark"
    env = "dev"
    service = "cart:search"
  }
}

# Give internet access to the VPC
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

# Create a subnet for our elb and ec2 instance
resource "aws_subnet" "default" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    contact = "j-mark"
    env = "dev"
    service = "cart:search"
  }
}

# Add a public key
resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)

  tags = {
    contact = "j-mark"
    env = "dev"
    service = "cart:search"
  }
}
