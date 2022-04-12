# Resource: aws_route_table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id # The VPC ID.
  route {
    cidr_block = "0.0.0.0/0"                 # The CIDR block of the route
    gateway_id = aws_internet_gateway.igw.id #identifier of the VPC internet gateway or a virtual private gateway
  }

  tags = { # A map of tags to assign to the resource
    Name = "private1"
  }
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.main.id # The VPC ID.
  route {
    cidr_block = "0.0.0.0/0"             # The CIDR block of the route
    gateway_id = aws_nat_gateway.nat1.id #identifier of the VPC internet gateway or a virtual private gateway
  }

  tags = { # A map of tags to assign to the resource
    Name = "private1"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.main.id # The VPC ID.
  route {
    cidr_block = "0.0.0.0/0"             # The CIDR block of the route
    gateway_id = aws_nat_gateway.nat2.id #identifier of the VPC internet gateway or a virtual private gateway
  }

  tags = { # A map of tags to assign to the resource
    Name = "private2"
  }
}


