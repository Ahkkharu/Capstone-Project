### This code allows you to set up an EKS cluster with 3 public and 3 private subnets. modify accordingly.
# you will need to have terraform, aws_cli installed and access to aws account.

# 1 Authenticate to the cloud so we can provision the kubernetes cluster. You can do this by running aws configure and giving your credentials, region and output format. make sure you have the right credentials policies to be able to provision a cluster.

# 2 Create a bucket and call it whatever you want. create a .tfvars file and put the name of the bucket in that .tfvars file thats located in 0.configurations_setup like this: 
```
BUCKET_NAME        =  "3tier-application-zoloproject87"
REGION_NAME = "us-east-1"
```
# specify region and availability zones
```
region                   = "us-east-1"
availability_zones_count = 2
```
# give a name for your cluster/project
```
project = "Balza"
```
# specify the CIDr blocks

```
vpc_cidr         = "10.0.0.0/16 need to change this"
subnet_cidr_bits = 8

```

### after creating the cluster you can connect to it by running
```
aws eks --region (region of cluster) update-kubeconfig --name (name of cluster)
```
