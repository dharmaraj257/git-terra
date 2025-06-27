provider "aws" {
  region = var.region_name
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name    = var.vpc_tag
    Service = "Terraform"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.subnet_az

  tags = {
    Name    = var.subnet_tag
    Service = "Terraform"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = var.igw_tag
    Service = "Terraform"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name    = var.rt_tag
    Service = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "allow_all"
    Service = "Terraform"
  }
}

resource "aws_instance" "Prod-Server" {
  ami                         = "ami-0a7d80731ae1b2435"
  availability_zone           = var.ec2_az
  instance_type               = var.ec2_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-1"
    Env        = "Prod"
    Owner      = "Raj"
    CostCenter = "ABCD"
  }
}