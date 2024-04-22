# IaC For Kubeadm Cluster on AWS EC2 using Terraform and Ansible

This repo can be used to bootstrap a cluster in Amazon EC2. Just fork this repo and follow the below steps to set things up.

---
## Architecture Diagram

---
## Modify terraform.tfvars

---
## Setup the Following Github Repository Secrets

---

## Run the `deploy cluster` workflow and obtain the KUBECONFIG from AWS Secrets

```
aws secretsmanager get-secret-value --secret-id $SECRET_ID  --query SecretBinary --output text | base64 --decode > $KUBECONFIG_PATH

```

### Access the cluster via kubectl

```
export KUBECONFIG=$KUBECONFIG_PATH
```

