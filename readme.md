# CloudForecast - Terraform Demonstration
This repo contains a sample Terraform configuration that sets up:

- 2 ELB instances
- 2 EC2 instances
- 1 RDS database

It is designed to demonstrate using tags to help system administrators
keep their resources organized and maintained.

## Deploying this
- Install and set up the AWS CLI
- Generate an SSH private key locally
- Apply your configuration: 

```
terraform apply -var 'public_key_path=~/.ssh/terraform.pub' -var 'private_key_path=~/.ssh/terraform' -var 'key_name=terraform'
```
