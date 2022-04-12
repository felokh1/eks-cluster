resource "aws_subnet" "publicsubnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true # Required for EKS. Instance launched into the subnet should be assigned 

  tags = {
    Name                        = "public-us-east-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.1o/role/elb"    = 1

  }
}

resource "aws_subnet" "publicsubnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true # Required for EKS. Instance launched into the subnet should be assigned 

  tags = {
    Name                        = "public-us-east-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.1o/role/elb"    = 1

  }
}

resource "aws_subnet" "privatesubnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true # Required for EKS. Instance launched into the subnet should be assigned 

  tags = {
    Name                        = "public-us-east-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.1o/role/elb"    = 1

  }
}

resource "aws_subnet" "privatesubnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true # Required for EKS. Instance launched into the subnet should be assigned 

  tags = {
    Name                        = "public-us-east-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.1o/role/elb"    = 1

  }
}