# VPC Configuration

# Data Source for Availability Zones
data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "${var.project_name}-vpc"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
}

# 1. Public Subnets
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[0]
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "${var.project_name}-public-subnet-a"
    }
  )
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[1]
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "${var.project_name}-public-subnet-b"
    }
  )
}

# 2. Private Subnets
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[0]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "${var.project_name}-private-subnet-a"
    }
  )
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[1]
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "${var.project_name}-private-subnet-b"
    }
  )
}

# 3. NAT Gateways (One per AZ for HA)
resource "aws_eip" "nat_a" {
  vpc  = true
  tags = merge(local.default_tags, local.environment_tags, { Name = "${var.project_name}-eip-nat-a" })
}

resource "aws_eip" "nat_b" {
  vpc  = true
  tags = merge(local.default_tags, local.environment_tags, { Name = "${var.project_name}-eip-nat-b" })
}

resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.public_a.id
  tags          = merge(local.default_tags, local.environment_tags, { Name = "${var.project_name}-nat-a" })
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.nat_b.id
  subnet_id     = aws_subnet.public_b.id
  tags          = merge(local.default_tags, local.environment_tags, { Name = "${var.project_name}-nat-b" })
}

# 4. Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.default_tags, local.environment_tags, { Name = "${var.project_name}-public-rt" })
}

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_a.id
  }

  tags = merge(local.default_tags, local.environment_tags, { Name = "${var.project_name}-private-rt-a" })
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_b.id
  }

  tags = merge(local.default_tags, local.environment_tags, { Name = "${var.project_name}-private-rt-b" })
}

# Route Table Associations
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}

# 5. Security Groups

# SG for ECS Tasks
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.project_name}-ecs-tasks-sg"
  description = "Allow inbound from ALB and all outbound"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, local.environment_tags, { Name = "${var.project_name}-ecs-tasks-sg" })
}

# SG for Load Balancer
resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP inbound"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, local.environment_tags, { Name = "${var.project_name}-alb-sg" })
}
