### This code allows you to set up an EKS cluster with 3 public and 3 private subnets. modify accordingly.
# you will need to have terraform, aws_cli installed and access to aws account.

# Set the backend so the state file is saved in an s3 bucket by running 
```
source ../scripts/setenv.sh 
```
# Run 
```
terraform init
```
# The following command will show you the plan of what is going to be created. 
```
terraform plan  --var-file ../0.account_configurations/terraform.tfvars
```
# apply the command after satisfied with the configurations
```
terraform apply  --var-file ../0.account_configurations/terraform.tfvars
```

### connect to the cluster by running:

```
aws eks --region xx-region-x update-kubeconfig --name name-of-cluster
```

### run this command to start the metrics server. 

```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

```

### If the cluster is going to have stateful sets, we need ebs csi provider installed to enable dynamic provisioning.
### The configuration is already applied and you can check by running this command:
```
kgp -n kube-system
```
### This will show the pods for ebs-csi-controller 6/6 and 3/3 all running. 

### if you want to do it manually you can run the following commands:

```
	aws eks describe-cluster \
	  --name (name_of_cluster) \
	  --query "cluster.identity.oidc.issuer" \
  --output text
```
### You will have an output. you gotta take note of the last section's numbers. copy them and create a file called "aws-ebs-csi-driver-trust-policy.json" and change the region and the number of the oidc provider as well as your account number. 

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::111122223333:oidc-provider/oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE:aud": "sts.amazonaws.com",
          "oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}

```
### run this command 

```
	aws iam create-role \
	  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --assume-role-policy-document file://"aws-ebs-csi-driver-trust-policy.json"
```

### run this command to attach the polycy to the role.

```

	aws iam attach-role-policy \
	  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --role-name AmazonEKS_EBS_CSI_DriverRole
```
### create the add-on. change to the correct cluster name and account number.
```
aws eks create-addon --cluster-name (cluster
-name) --addon-name aws-ebs-csi-driver \
  --service-account-role-arn arn:aws:iam::715072217548:role/AmazonEKS_EBS_CSI_DriverRole
```

### this command to restart the deployment. this should make it so you can provision ebs volumes with the pvc.

```
kubectl rollout restart deployment ebs-csi-controller -n kube-system
```

