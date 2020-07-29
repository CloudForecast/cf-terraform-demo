# A security group for the database
resource "aws_security_group" "db" {
  name        = "terraform_example_db"
  description = "Used in the terraform"
  vpc_id      = aws_vpc.default.id

  # Only allow access from the VPC
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    contact = "l-duke"
    env = "dev"
    service = "cart:search"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mysql_db_1"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"

  tags = {
    contact = "l-duke"
    env = "dev"
    service = "cart:search"
  }
}
