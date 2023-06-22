# TDR AWS Accounts

This repository contains code to configure AWS accounts to support the TDR infrastructure and application.
There are two scripting languages used:
* Terraform
* Python

Code using each language is deployed separately, see sections below.

## Account level configurations - Terraform
* Sets IAM password policy to comply with CIS AWS Foundation Benchmark
* Configures GuardDuty and enables in all regions
* Turns on Config in all regions
* Configures CloudTrail at AWS account level
* Configures Security Hub
* Creates hosted zone
* Creates Simple Email Service
* Centralised security logs
* Athena configuration and example queries to create tables, partition and search

![Alt text](aws-centralized-logs.png?raw=true "Centralised security logs")

## Account level configurations - Python
* Deletes default VPCs in all regions

## Add a new team to the repository
* Add your team name to the input variable in [the apply workflow](./.github/workflows/apply.yml)
* Add the role name which terraform runs with into the `delete-default-vpcs.py` script. There are existing examples for TDR and DR2.
* For each environment you need to deploy to, you will need to set these secrets. There are descriptions of what each one is needed for in the [da-terraform-configurations](https://github.com/nationalarchives/da-terraform-configurations) repository. The project name must be the same as the name in the `apply.yml` choice field but in upper case.
    * {PROJECT}_{ENV_NAME}_ACCOUNT_NUMBER
    * {PROJECT}_{ENV_NAME}_DYNAMO_TABLE
    * {PROJECT}_{ENV_NAME}_STATE_BUCKET
    * {PROJECT}_{ENV_NAME}_TERRAFORM_EXTERNAL_ID
    * {PROJECT}_{ENV_NAME}_TERRAFORM_ROLE
* You will also need to set the following secrets which don't depend on the environment.
    * {PROJECT}_EMAIL_ADDRESS
    * {PROJECT}_MANAGEMENT_ACCOUNT
    * {PROJECT}_SLACK_WEBHOOK
    * {PROJECT}_WORKFLOW_PAT 
* Set up an environment in GitHub called {project-lower-case}-{environment-lower-case} for each environment you will deploy to.
* Run the GitHub actions apply workflow. This will deploy to the chosen environment and delete the default VPCs from each region. 

