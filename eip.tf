# Resource EIP
#  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip

resource "aws_eip" "eip1" {
  # EIP may require IGW to exist prior to association
  # Us depends _on to set an explicit dependency on the IGW
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "eip2" {
  # EIP may require IGW to exist prior to association
  # Us depends _on to set an explicit dependency on the IGW
  depends_on = [aws_internet_gateway.igw]
}