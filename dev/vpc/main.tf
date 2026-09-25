
# -------------------
# VPC & IGW
# -------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-vpc"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-igw"
  })
}

# -------------------
# App subnets
# -------------------
resource "aws_subnet" "app_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-app-subnet-${local.az_map["ap-south-1a"]}-01"
  })
}

resource "aws_subnet" "app_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-app-subnet-${local.az_map["ap-south-1b"]}-01"
  })
}

resource "aws_subnet" "app_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1c"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-app-subnet-${local.az_map["ap-south-1c"]}-01"
  })
}


# -------------------
# DB subnets
# -------------------
resource "aws_subnet" "db_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-south-1a"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-db-subnet-${local.az_map["ap-south-1a"]}-01"
  })
}

resource "aws_subnet" "db_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "ap-south-1b"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-db-subnet-${local.az_map["ap-south-1b"]}-01"
  })
}

resource "aws_subnet" "db_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.13.0/24"
  availability_zone = "ap-south-1c"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-db-subnet-${local.az_map["ap-south-1c"]}-01"
  })
}


# -------------------
# Web subnets
# -------------------
resource "aws_subnet" "web_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "ap-south-1a"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-web-subnet-${local.az_map["ap-south-1a"]}-01"
  })
}

resource "aws_subnet" "web_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "ap-south-1b"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-web-subnet-${local.az_map["ap-south-1b"]}-01"
  })
}

resource "aws_subnet" "web_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.23.0/24"
  availability_zone = "ap-south-1c"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-web-subnet-${local.az_map["ap-south-1c"]}-01"
  })
}


# -------------------
# ECS subnets
# -------------------
resource "aws_subnet" "ecs_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.31.0/24"
  availability_zone = "ap-south-1a"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-ecs-subnet-${local.az_map["ap-south-1a"]}-01"
  })
}

resource "aws_subnet" "ecs_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/24"
  availability_zone = "ap-south-1b"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-ecs-subnet-${local.az_map["ap-south-1b"]}-01"
  })
}

resource "aws_subnet" "ecs_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.33.0/24"
  availability_zone = "ap-south-1c"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-ecs-subnet-${local.az_map["ap-south-1c"]}-01"
  })
}


# -------------------
# EKS subnets
# -------------------
resource "aws_subnet" "eks_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.41.0/24"
  availability_zone = "ap-south-1a"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-eks-subnet-${local.az_map["ap-south-1a"]}-01"
  })
}

resource "aws_subnet" "eks_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.42.0/24"
  availability_zone = "ap-south-1b"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-eks-subnet-${local.az_map["ap-south-1b"]}-01"
  })
}

resource "aws_subnet" "eks_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.43.0/24"
  availability_zone = "ap-south-1c"

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-eks-subnet-${local.az_map["ap-south-1c"]}-01"
  })
}


# -------------------
# Route tables
# -------------------
resource "aws_route_table" "app" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-app-route-table-common"
  })
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id
  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-db-route-table-common"
  })
}

resource "aws_route_table" "web" {
  vpc_id = aws_vpc.main.id
  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-web-route-table-common"
  })
}

resource "aws_route_table" "ecs" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-ecs-route-table-common"
  })
}

resource "aws_route_table" "eks" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-eks-route-table-common"
  })
}


# -------------------
# Associations
# -------------------
# App
resource "aws_route_table_association" "app_a" {
  subnet_id      = aws_subnet.app_a.id
  route_table_id = aws_route_table.app.id
}
resource "aws_route_table_association" "app_b" {
  subnet_id      = aws_subnet.app_b.id
  route_table_id = aws_route_table.app.id
}
resource "aws_route_table_association" "app_c" {
  subnet_id      = aws_subnet.app_c.id
  route_table_id = aws_route_table.app.id
}

# DB
resource "aws_route_table_association" "db_a" {
  subnet_id      = aws_subnet.db_a.id
  route_table_id = aws_route_table.db.id
}
resource "aws_route_table_association" "db_b" {
  subnet_id      = aws_subnet.db_b.id
  route_table_id = aws_route_table.db.id
}
resource "aws_route_table_association" "db_c" {
  subnet_id      = aws_subnet.db_c.id
  route_table_id = aws_route_table.db.id
}

# Web
resource "aws_route_table_association" "web_a" {
  subnet_id      = aws_subnet.web_a.id
  route_table_id = aws_route_table.web.id
}
resource "aws_route_table_association" "web_b" {
  subnet_id      = aws_subnet.web_b.id
  route_table_id = aws_route_table.web.id
}
resource "aws_route_table_association" "web_c" {
  subnet_id      = aws_subnet.web_c.id
  route_table_id = aws_route_table.web.id
}

# ECS
resource "aws_route_table_association" "ecs_a" {
  subnet_id      = aws_subnet.ecs_a.id
  route_table_id = aws_route_table.ecs.id
}
resource "aws_route_table_association" "ecs_b" {
  subnet_id      = aws_subnet.ecs_b.id
  route_table_id = aws_route_table.ecs.id
}
resource "aws_route_table_association" "ecs_c" {
  subnet_id      = aws_subnet.ecs_c.id
  route_table_id = aws_route_table.ecs.id
}

# EKS
resource "aws_route_table_association" "eks_a" {
  subnet_id      = aws_subnet.eks_a.id
  route_table_id = aws_route_table.eks.id
}
resource "aws_route_table_association" "eks_b" {
  subnet_id      = aws_subnet.eks_b.id
  route_table_id = aws_route_table.eks.id
}
resource "aws_route_table_association" "eks_c" {
  subnet_id      = aws_subnet.eks_c.id
  route_table_id = aws_route_table.eks.id
}
