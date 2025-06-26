resource "aws_s3_bucket" "dharmaraj000001" {
  bucket = "dharmaraj000001"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  depends_on = [aws_route_table_association.Pub-RTA-Terra]
}

resource "aws_s3_bucket" "dharmaraj000002" {
  bucket = "dharmaraj000002"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  depends_on = [ aws_s3_bucket.dharmaraj000001 ]
}

resource "aws_s3_bucket" "dharmaraj000003" {
  bucket = "dharmaraj000003"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  depends_on = [aws_s3_bucket.dharmaraj000002]
}