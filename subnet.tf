resource "aws_subnet" "Public-Subnet-Terraform" {
  vpc_id                  = aws_vpc.Vpc-Terraform.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name    = "Public-Subnet-Terraform"
    Service = "Terraform"
  }
}