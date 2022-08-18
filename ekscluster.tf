resource "aws_eks_cluster" "aws_eks" {
  role_arn = aws_iam_role.eks_cluster.arn
  name     = "${var.name}-eks_cluster"

  vpc_config {
    subnet_ids = [aws_subnet.public_subnets[0].id, aws_subnet.public_subnets[1].id]
  }

  tags = {
    Name = "${var.name}-eks_cluster"
  }
}

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "${var.name}-node-group"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = [aws_subnet.public_subnets[0].id, aws_subnet.public_subnets[1].id]

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]
}
