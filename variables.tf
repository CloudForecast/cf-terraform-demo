variable "tags" {
  description = "The tags for this resource."
  validation {
    condition = length(var.tags) > 0 && contains(["j-mark", "l-duke"], var.tags.contact) && contains(["dev", "prod"], var.tags.env) && contains(["cart", "search", "cart:search"], var.tags.service)
    error_message = "Invalid resource tags applied."
  }
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "private_key_path" {
  description = <<DESCRIPTION
Path to the SSH private key to be used for authentication.
Example: ~/.ssh/terraform
DESCRIPTION
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-2"
}

# Ubuntu Precise 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-east-2 = "ami-0c8110836d05ad7bd"
  }
}

variable "db_username" {
  description = "RDS database user"
  default     = "admin"
}

variable "db_password" {
  description = "RDS database password"
  default     = "password123"
}

