# output "public_subnets" {
#   value = aws_instance.awsec2[*].public_ip
# }

output "my_ip_addr" {
  value = data.http.my_public_ip.body
}



output "eks_cluster_endpoint" {
  value = aws_eks_cluster.aws_eks.endpoint
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.aws_eks.certificate_authority
}
