# This block is used to setup cert-manager
variable "cert-manager-config" {
  type        = map(any)
  description = "Please define cert-manager configurations"
  default = {
    deployment_name = "cert-manager"
    chart_version   = "1.10.0"
  }
}

variable "external-dns-config" {
  type        = map(any)
  description = "Please define external-dns configurations"
  default = {
    deployment_name = "external-dns"
    chart_version   = "6.11.3"
  }
}

variable "email" {}

# This block is used to setup prometheus
variable "prometheus-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name = "prometheus"
    chart_version   = "15.17.0"
  }
}



# This block is used to setup grafana
variable "grafana-config" {
  type = map(any)
  default = {
    deployment_name = "grafana"
    chart_version   = "6.43.3"
    adminPassword   = "password"
    adminUser       = "admin"
  }
}

# This block is used to setup kube-state-metrics
variable "kube-state-metrics-config" {
  type = map(any)
  default = {
    deployment_name = "kube-state-metrics"
    chart_version   = "4.22.1"
  }
}

variable "vault-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name = "vault"
    chart_version   = "0.22.1"
  }
}

variable "cluster-autoscaler-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name = "cluster-autoscaler"
    chart_version   = "9.21.0"
  }
}
variable "gke_config" {
  type        = map(any)
  description = "description"
  default = {
    region         = "us-central1"
    zone           = "us-central1-c"
    cluster_name   = "project-cluster"
    machine_type   = "e2-medium"
    node_count     = 1
    node_pool_name = "my-node-pool"
    preemptible    = true
    node_version   = "1.23.5-gke.1500" # finds build version automatically based on region. We can change it to 1.21   . In this case it will automatically find minor version
  }
}

variable "datadog-config" {
  type        = map(any)
  description = "Please provide datadog config"
  default = {
    deployment_name = "datadog"
    apiKey          = "486adc28b54026bb6a42480386407778"
    site            = "us5.datadoghq.com"
  }
}

variable "repository_id" {
  type    = string
  default = ""
}

variable "format" {
  type    = string
  default = "DOCKER"
}

variable "description" {
  type    = string
  default = ""
}

# This block is used to setup ingress controller
variable "ingress-controller-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name          = "ingress-controller"
    chart_version            = "4.3.0"
    loadBalancerSourceRanges = "0.0.0.0/0"
  }
}

variable "aws_domain_name" {
  default = ""
}

variable "project" {
  default = ""
}