# Resource: aws_route_table_association
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association


resource "aws_route_table_association" "public1" {

  subnet_id      = aws_subnet.publicsubnet1.id # The subnet ID to create an association
  route_table_id = aws_route_table.public.id   #The ID of the routing table to associate with
}

resource "aws_route_table_association" "public2" {

  subnet_id      = aws_subnet.publicsubnet1.id # The subnet ID to create an association
  route_table_id = aws_route_table.public.id   #The ID of the routing table to associate with
}

resource "aws_route_table_association" "private1" {

  subnet_id      = aws_subnet.privatesubnet1.id # The subnet ID to create an association
  route_table_id = aws_route_table.private1.id  #The ID of the routing table to associate with
}


resource "aws_route_table_association" "private2" {

  subnet_id      = aws_subnet.privatesubnet2.id # The subnet ID to create an association
  route_table_id = aws_route_table.private2.id  #The ID of the routing table to associate with
}