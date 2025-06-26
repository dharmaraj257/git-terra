resource "aws_route_table" "Pub-RT-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw-Terraform.id
  }
  tags = {
    Name    = "Pub-RT-Terraform"
    Service = "Terraform"
  }
}

resource "aws_route_table_association" "Pub-RTA-Terra" {
  subnet_id      = aws_subnet.Public-Subnet-Terraform.id
  route_table_id = aws_route_table.Pub-RT-Terraform.id
}
