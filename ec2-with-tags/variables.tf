variable "tags" {
  description = "The tags for this resource."
  validation {
    condition = length(var.tags) > 0 && contains(["j-mark", "l-duke"], var.tags.contact) && var.tags.env != null && contains(["cart", "search", "cart:search"], var.tags.service)
    error_message = "Invalid resource tags applied."
  }
}

# Ubuntu Precise 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-east-2 = "ami-0c8110836d05ad7bd"
  }
}

variable "aws_vpc_id" {
	description = "The AWS VPC ID"
}

variable "aws_key_pair_name" {
	description = "The AWS Key Pair name"
}

variable "private_key_path" {
  description = "SSH Private key path"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-2"
}
