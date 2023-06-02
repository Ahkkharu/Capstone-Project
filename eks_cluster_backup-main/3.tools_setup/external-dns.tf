# module "external-dns-terraform-k8s-namespace" {
#   source = "../modules/terraform-k8s-namespace/"
#   name   = "external-dns"
# }

module "external-dns-terraform-helm" {
#   depends_on = [
#     kubernetes_secret.external_dns_secret
#   ]
  source               = "../modules/terraform-helm/"
  deployment_name      = "external-dns"
  deployment_namespace = "external-dns"
  chart                = "external-dns"
  chart_version        = "6.11.3"
  repository           = "https://charts.bitnami.com/bitnami"
  values_yaml          = <<EOF

clusterDomain:  
provider: aws
aws:
  credentials:
    secretKey: ""
    accessKey: "" 

EOF
}

# resource "kubernetes_secret" "external_dns_secret" {
#   metadata {
#     name      = "google-service-account"
#     namespace = "external-dns"
#   }
#   data = {
#     "credentials.json" = "${file("${var.google_credentials_json}")}"
#   }
#   type = "generic"
# }