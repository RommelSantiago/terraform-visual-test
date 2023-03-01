resource "aws_eks_cluster" "cluster" {
    name = "cluster"
    role_arn = aws_iam_role.cluster_iam_role.arn

    vpc_config {
      subnet_ids = [ var.sn_a_id, var.sn_b_id ]
      endpoint_public_access = true
    }

    depends_on = [
      aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
    ]
}

# EKS Cluster IAM Role
resource "aws_iam_role" "cluster_iam_role" {
  name = "cluster_iam_role"

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

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.cluster_iam_role.name
}

resource "aws_eks_node_group" "node_group" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = "node_group"
  node_role_arn = aws_iam_role.cluster_iam_role.arn
  subnet_ids = [ var.sn_a_id ]

  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 1
  }
  ami_type = "AL2_x86_64"
  disk_size = 20
  instance_types = [ "t2.micro" ]

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}