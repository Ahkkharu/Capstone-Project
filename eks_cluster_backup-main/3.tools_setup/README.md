### this section sets up external dns, cert manager and nginx ingress controller that will create a loadbalancer for a nentry point to our cluster. 

### make sure to add the following parts to ../0.configurations_setup/terraform.tfvars 

```
# This block is used to setup ingress controller
ingress-controller-config = {
  deployment_name = "ingress-controller"
  chart_version            = "4.3.0"
  loadBalancerSourceRanges = "0.0.0.0/0"
}

# This block is used to setup cert-manager
cert-manager-config = {
  deployment_name = "cert-manager"
  chart_version = "1.10.0"
}

```

### run

```
source ../scripts/setenv.sh 

```

### run 

```
terraform init 
```
### run

``` 
terraform apply --var-file ../0.configurations_setup/terraform.tfvars 
```
