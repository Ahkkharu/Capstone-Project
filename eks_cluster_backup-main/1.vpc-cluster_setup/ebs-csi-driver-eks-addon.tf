data "tls_certificate" "eks" {
    url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
    client_id_list = ["sts.amazonaws.com"]
    thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
    url             = aws_eks_cluster.this.identity[0].oidc[0].issuer

}



data "aws_iam_policy_document" "csi" {
 statement {
   actions =  ["sts:AssumeRoleWithWebIdentity"]
   effect   = "Allow"

   condition {
    test = "StringEquals"
    variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
    values = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
   }
    principals {
        identifiers = [aws_iam_openid_connect_provider.eks.arn]
        type = "Federated"
    }

 }

}


resource "aws_iam_role" "eks_ebs_csi_driver" {
    assume_role_policy = data.aws_iam_policy_document.csi.json #file("${path.module}/aws-ebs-csi-driver-trust-policy.json") # having to create that json file manually. from amazon docs. what would go here is "data.aws_iam_policy_document.csi.json"
    name = "eks-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "amazon_ebs_csi_driver" {
role = aws_iam_role.eks_ebs_csi_driver.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"

}


resource "aws_eks_addon" "csi_driver" {
    cluster_name = "Balza-cluster"
    addon_name = "aws-ebs-csi-driver"
    addon_version = "v1.16.0-eksbuild.1" # "aws eks describe-addon-versions --addon-name aws-ebs-csi-driver" command to know what versions I can install
    service_account_role_arn = aws_iam_role.eks_ebs_csi_driver.arn
}