# CloudForecast - Terraform Demonstration
This repo contains a sample Terraform configuration that sets up an EC2 instance behind an ELB. It is designed to demonstrate using tags to help system administrators keep their resources organized and maintained.

## Deploying this
- Install and set up the AWS CLI
- Generate an SSH private key locally
- Copy the `terraform.tfvars.example` file to `terraform.tfvars` and add your SSH key values.
- Apply your configuration: 

```
terraform apply
```
