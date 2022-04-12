# Resource Nat_Gateway
#  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway


resource "aws_nat_gateway" "nat1" {
  # The allocation ID of the Elastic IP address for the gateway
  allocation_id = aws_eip.eip1.id

  # The subnet ID of the subnet in which to place the gateway
  subnet_id = aws_subnet.publicsubnet1.id

  # A map of tags to assign to the resource
  tags = {
    Name = "NAT1"
  }
}

resource "aws_nat_gateway" "nat2" {
  # The allocation ID of the Elastic IP address for the gateway
  allocation_id = aws_eip.eip2.id

  # The subnet ID of the subnet in which to place the gateway
  subnet_id = aws_subnet.publicsubnet2.id

  # A map of tags to assign to the resource
  tags = {
    Name = "NAT2"
  }
}