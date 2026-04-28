# ------------- Create VPC -----------------------
resource "aws_vpc" "vpc_k8s" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# ------------- Create Subnet -----------------------
resource "aws_subnet" "subnet_k8s" {
  vpc_id                  = aws_vpc.vpc_k8s.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "${var.project_name}-subnet"
    "kubernetes.io/role/elb" = "1" # Required for AWS Load Balancer Controller
  }
}

# ------------- Internet Gateway -----------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_k8s.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# ------------- Route Table -----------------------
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc_k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_k8s.id
  route_table_id = aws_route_table.rt.id
}
