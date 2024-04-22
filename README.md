# IaC For Kubeadm Cluster on AWS EC2 using Terraform and Ansible

This repo can be used to bootstrap a cluster in Amazon EC2. Just fork this repo and follow the below steps to set things up.
Terraform is used to provision the infrastructure and Ansible is used to configure the kubeadm cluster on the nodes.

---
## Configure an AWS ROLE for Keyless Authentication to AWS

Follow this [link](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/) to setup Keyless Authentication to AWS using Github as OIDC Provider

> Also allow this role to access the S3 backend configured for storing terraform state files

---
## Architecture Diagram
![image](https://github.com/harsh098/kubeadm-cluster-with-terraform-ansible-ec2/assets/23445112/87dc04e4-2bc4-4448-b176-2a776869015e)


---
## Modify terraform.tfvars  

The file `terraform/tfvars` contains all variables you need in order to tweak the provisioning of the cluster

---
## Setup the Following Github Repository Secrets

| Secret  | Description   |
|---|---|
| `AWS_ROLE`  | This role is used by Github Actions to run Terraform modules and access AWS Secrets via Keyless Authentication to AWS via OIDC  |
| `AWS_REGION`  | Region to deploy the cluster in|
| `AWS_KUBECONFIG_SECRET` |  Name of the AWS Secret |

---

## Run the `deploy cluster` workflow and obtain the KUBECONFIG from AWS Secrets

```
aws secretsmanager get-secret-value --secret-id $SECRET_ID  --query SecretBinary --output text | base64 --decode > $KUBECONFIG_PATH

```

### Deployment Steps
![image](https://github.com/harsh098/kubeadm-cluster-with-terraform-ansible-ec2/assets/23445112/b155af0e-2456-4043-b510-78985b117d8c)


### Access the cluster via kubectl

```
export KUBECONFIG=$KUBECONFIG_PATH
```

![image](https://github.com/harsh098/kubeadm-cluster-with-terraform-ansible-ec2/assets/23445112/33fcbf47-d24f-4c82-aac5-83170a8da9f7)

---

## Destroying the infra
### Run the `destroy_infra` github action manually
![image](https://github.com/harsh098/kubeadm-cluster-with-terraform-ansible-ec2/assets/23445112/5d20bda6-61c8-4927-aa1d-1fb3a3d5f3d3)

![image](https://github.com/harsh098/kubeadm-cluster-with-terraform-ansible-ec2/assets/23445112/4374665a-2e5c-467c-a647-6e40fa9ac1d6)

