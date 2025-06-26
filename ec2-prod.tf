resource "aws_instance" "Prod-Server" {
  ami                         = "ami-0a7d80731ae1b2435"
  availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
  key_name                    = "Test"
  subnet_id                   = aws_subnet.Public-Subnet-Terraform.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-1"
    Env        = "Prod"
    Owner      = "Raj"
    CostCenter = "ABCD"
  }
}