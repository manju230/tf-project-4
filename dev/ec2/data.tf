# -------------------
# Fetch VPC by tag
# -------------------
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["${local.prefix}-vpc"]
  }
}

# -------------------
# Fetch subnets by tag
# -------------------
data "aws_subnet" "app_a" {
  filter {
    name   = "tag:Name"
    values = ["${local.prefix}-app-subnet-${local.az_map["ap-south-1a"]}-01"]
  }
}

data "aws_subnet" "app_b" {
  filter {
    name   = "tag:Name"
    values = ["${local.prefix}-app-subnet-${local.az_map["ap-south-1b"]}-01"]
  }
}

data "aws_subnet" "app_c" {
  filter {
    name   = "tag:Name"
    values = ["${local.prefix}-app-subnet-${local.az_map["ap-south-1c"]}-01"]
  }
}


data "aws_ami" "amazon-linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_iam_instance_profile" "ec2_profile_data" {
  name = aws_iam_instance_profile.ec2_profile.name
}
