# ESK Cluster
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

resource "aws_iam_role" "eks-cluster" {
  # The name of the role
  name = "eks-cluster"
  # The policy that grants an entity permission to assume the role
  # Used to access AWS resources that you might not normally have access too
  # The role that Amazon EKS will use to create AWS resources for Kubernetes cluster
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  # The ARN of the policy you want to apply  
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  # The role of the policy should be applied to 
  role = aws_iam_role.eks-cluster.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-cluster.name
}

# Resource: EKS
resource "aws_eks_cluster" "eks" {
  name = "eks"
  # The Amazon Resource Name (ARN) of the IAM role that provides permissions for
  #Kubernetes control plane to make calls to AWS API operations on your behalf
  role_arn = aws_iam_role.eks-cluster.arn

  vpc_config {

    endpoint_private_access = false # Indicate whether or not the Amazon EKS private API server endpoint it enabled
    endpoint_public_access  = true  # Indicate whether or not the Amazon EKS public API server endpoint it enabled

    subnet_ids = [
      aws_subnet.publicsubnet1.id,
      aws_subnet.publicsubnet2.id,
      aws_subnet.privatesubnet1.id,
      aws_subnet.privatesubnet2.id
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role.eks-cluster,
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}
