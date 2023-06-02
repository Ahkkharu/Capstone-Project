### This repo is used to deploy namespaces


# Usage: 

#### 1. Configure backend
```
source ../scripts/setenv.sh
```

#### 2. Initialize terraform 
```
terraform  init 
```
#### 3. Create 
```
terraform apply

### if you encounter an issue with the execplugin. you make sure you update the awscli and that you change the alpha part to beta by running this comand sed -i -e "s,client.authentication.k8s.io/v1alpha1,client.authentication.k8s.io/v1beta1,g" ~/.kube/config" this will change your kube config file to use the beta instead of the alpha. the result is apiVersion: client.authentication.k8s.io/v1beta1
```