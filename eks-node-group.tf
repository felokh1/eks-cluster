# Resource: aws_eks_node_group
# https://registry.terraform.io/providers/aaronfeng/aws/latest/docs/resources/eks_node_group

# Create IAM role for EKS Node Group
resource "aws_iam_role" "nodes_general" {
  # The name of the role
  name = "eks-node-group-general"
  
  # The policy that grants an entity permission to assume the role
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


# Resource: Example IAM Role for EKS Node Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group#example-iam-role-for-eks-node-group
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy" # The ARN of the policy you want to apply
  role       = aws_iam_role.nodes_general.name                  # The role the policy should be applied to
}

# Resource: Example IAM Role for EKS Node Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group#example-iam-role-for-eks-node-group
resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" # The ARN of the policy you want to apply
  role       = aws_iam_role.nodes_general.name                # The role the policy should be applied to
}

# Resource: Example IAM Role for EKS Node Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group#example-iam-role-for-eks-node-group
resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" # The ARN of the policy you want to apply
  role       = aws_iam_role.nodes_general.name                              # The role the policy should be applied to
}

# Resource: aws_eks_node_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group#example-iam-role-for-eks-node-group

resource "aws_eks_node_group" "general_nodes" {
  cluster_name    = aws_eks_cluster.eks.name       # Name of the EKS Cluter
  node_group_name = "nodes_general"                # Name of the EKS Node Group
  node_role_arn   = aws_iam_role.nodes_general.arn # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS

  # Identifiers of EC2 Subnets to associate with the EKS Node Group.
  # These subnets must have the following resource tag: kubernetes.io/cluster_
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
  subnet_ids = [
    aws_subnet.privatesubnet1.id,
    aws_subnet.privatesubnet2.id
  ]

  # Configuration block with scaling settings
  scaling_config {
    desired_size = 1 # Desire number of worker nodes
    max_size     = 1 # Maximum number of worker nodes
    min_size     = 1 # Minimum number of worker nodes
  }

# Type of Amazon Machine Image (AMI) associated with the EKS Node Group
# https://docs.aws.amazon.com/eks/latest/APIReference/API_Nodegroup.html#AmazonEKS-Type-Nodegroup-amiType
# Valid value: AL2_X86_64, AL2_x86_64_GPU, AL2_ARM_64
ami_type             = "AL2_x86_64"
capacity_type        = "ON_DEMAND"  # Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT
disk_size            = 20           # Disk size in GiB for worker nodes
force_update_version = false        # Force version update if existing pods are unable to be drained due to a pod disruption budget issue
instance_types        = ["t2.medium"] # List of instance types associated with the EKS Node Group

labels = {
  role = "nodes-general"
}

# Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
# Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
depends_on = [
  aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
  aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
  aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
]
}

