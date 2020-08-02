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
}

# Create an internet gateway for outside access
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

# Give internet access to the VPC
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

# Add a public key
resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

module "ec2_with_tags" {
  source = "./ec2-with-tags"
  aws_vpc_id = aws_vpc.default.id
  aws_key_pair_name = aws_key_pair.auth.key_name
  aws_region = var.aws_region
  private_key_path = var.private_key_path
  tags = {
    contact = "j-mark"
    env = "dev"
    service = "cart"
  }
}
