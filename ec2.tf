# A security group for the EC2 instances
resource "aws_security_group" "default" {
  name        = "terraform_example"
  description = "Used in the terraform"
  vpc_id      = aws_vpc.default.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
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
    contact = "j-mark"
    env = "dev"
    service = "cart:search"
  }
}

resource "aws_instance" "cart" {
  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    private_key = file(var.private_key_path)
  }

  instance_type = "t2.micro"

  ami = var.aws_amis[var.aws_region]

  key_name = aws_key_pair.auth.key_name

  vpc_security_group_ids = [aws_security_group.default.id]

  subnet_id = aws_subnet.default.id

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
    ]
  }

  tags = {
    contact = "j-mark"
    env = "dev"
    service = "cart"
  }
}

resource "aws_instance" "search" {
  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    private_key = file(var.private_key_path)
  }

  instance_type = "t2.micro"

  ami = var.aws_amis[var.aws_region]

  key_name = aws_key_pair.auth.key_name

  vpc_security_group_ids = [aws_security_group.default.id]

  subnet_id = aws_subnet.default.id

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
    ]
  }

  tags = {
    contact = "l-duke"
    env = "dev"
    service = "search"
  }
}
