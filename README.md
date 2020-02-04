# TDR AWS Accounts

This repository contains code to configure AWS accounts to support the TDR infrastructure and application

## Account level configurations
* Sets IAM password policy to comply with CIS AWS Foundation Benchmark

## USAGE

### Install Git Secrets
* Install AWS [git-secrets](https://github.com/awslabs/git-secrets) to prevent accidentally committing sensitive AWS data

### Deploy to Management environment
* Deploy from a developer laptop
* Duplicate terraform.tfvars.example, removing the .example suffix
* Update with the AWS account number of the management account
* Ensure that there is a role "IAM_Admin_Role" with a trust relationship to the same account, i.e. the management account
```
terraform init
terraform workspace select mgmt
terraform plan
terraform apply
```
### Deploy to other environments
* Deploy using Jenkins pipeline