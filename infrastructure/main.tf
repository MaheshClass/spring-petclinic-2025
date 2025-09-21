module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.31"
  cluster_name    = "demo-eks-cluster"
  cluster_version = "1.31"

  cluster_endpoint_public_access            = true
  enable_cluster_creator_admin_permissions  = true


  vpc_id     = "aws_vpc.eks_vpc.id"
  subnet_ids = ["aws_subnet.public_subnet_1.id", "aws_subnet.public_subnet_2.id", "aws_subnet.private_subnet_1.id", "aws_subnet.private_subnet_2.id"]

  eks_managed_node_groups = {
    example = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      tags = {
        Environment = "dev"
        Terraform   = "true"
      }
    }
  }
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
