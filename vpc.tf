resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16" #The Cidr block for the VPC
  instance_tenancy = "default"     #Ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. 

  enable_dns_support   = true # Required for EKS. Enable/disable DNS support in the VPC
  enable_dns_hostnames = true # Required for EKS. Enable/disable DNS hostname in the VPC

  enable_classiclink               = false # Enable/disable classiclink for the VPC
  enable_classiclink_dns_support   = false # Enable/disable classiclink DNS support for the VPC
  assign_generated_ipv6_cidr_block = false # Requests an Amazon-provided IPV6 Cidr block with a /56 prefix length


  tags = {
    Name = "main" # A map of tags to assign
  }
}