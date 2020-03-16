# TDR AWS Accounts

This repository contains code to configure AWS accounts to support the TDR infrastructure and application.
There are two scripting languages used:
* Terraform
* Python

Code using each language is deployed separately, see sections below.

## Account level configurations
* Sets IAM password policy to comply with CIS AWS Foundation Benchmark (terraform)
* Configures GuardDuty and enables in all regions (terraform)
* Deletes default VPCs in all regions (python)

## USAGE - TERRAFORM

### Install Git Secrets
* Install AWS [git-secrets](https://github.com/awslabs/git-secrets) to prevent accidentally committing sensitive AWS data

## TERRAFORM

### Deploy to Management environment
* Deploy from a developer laptop
* Duplicate terraform.tfvars.example, removing the .example suffix
* Update with the AWS account number of the management account
* Ensure that there is a role "IAM_Admin_Role" with a trust relationship to the same account, i.e. the management account
```
terraform init
terraform workspace select mgmt
terraform plan
```
* if the Route53 hosted zone has been created manually, before applying terraform, e.g.:
```
terraform import module.route_53_zone.aws_route53_zone.hosted_zone Z4KAPRWWNC7JR
terraform import module.route_53_zone.aws_route53_record.hosted_zone_ns Z4KAPRWWNC7JR_tdr-management.nationalarchives.gov.uk_NS_tdr-management
```
* replace the dummy ZoneID  with the actual one
* once any manually created items have been imported:
```
terraform plan
terraform apply
```

### Delegation of hosted zone from corporate DNS
* ensure that any newly created hosted zone is delegated by corporate DNS
* this will be required before SES domain can be verified

### Deploy to Sandbox environment
* Deploy from a developer laptop
* Use AWS credentials from the TDR Manager account
* Update the AWS account number in your terraform.tfvars to the sandbox account
```
terraform workspace select sbox
terraform plan
terraform apply
```

### Deploy to Dev DRI (TDR Prototype) environment
* Deploy from a developer laptop
* Use AWS credentials from the TDR Manager account
* Update the AWS account number in your terraform.tfvars to the sandbox account
```
terraform workspace select ddri
terraform plan
terraform apply
```

### Deploy Terraform to Integration and Production environments
* Deploy using Jenkins pipeline

## USAGE - PYTHON

### Deploy to Management environment
* Install Python 3.7 or later to your laptop
* Install AWS CLI and 
* Create a virtual environment
```
virtualenv -p python3 /Users/YOUR-USERNAME/venv
```

* Activate virtual environment
```
source /Users/YOUR-USERNAME/venv/python3/bin/activate
```
* Install dependencies
```
pip install boto3
```
* Delete Default VPCs
```
python delete-default-vpcs --dry_run
python delete-default-vpcs
```

### Deploy Python to Integration and Production environments
* Deploy using Jenkins pipeline