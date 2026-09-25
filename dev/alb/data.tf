# -------------------
# Fetch VPC by tag
# -------------------
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["${local.prefix}-vpc"]
  }
}

data "aws_subnet" "app_a" {
  filter {
    name   = "tag:Name"
    values = ["mumbai-vpc-app-subnet-az1-01"]
  }
}

data "aws_subnet" "app_b" {
  filter {
    name   = "tag:Name"
    values = ["mumbai-vpc-app-subnet-az2-01"]
  }
}

 


data "aws_instance" "app_server" {
  filter {
    name   = "tag:Name"
    values = ["${local.prefix}-app-server"]
  }
}

data "aws_security_group" "app_sg" {
  name   = "mumbai-vpc-app-sg"   # replace with actual SG name
  vpc_id = aws_vpc.main.id           # optional, helps disambiguate if multiple SGs have same name
}
