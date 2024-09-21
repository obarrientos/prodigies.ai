/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform --version

# General Terraform Commands

# Initializes a new or existing Terraform configuration
terraform init

# Validates the configuration files
terraform validate

# Formats Terraform configuration files to a canonical style
terraform fmt

# Creates an execution plan to show actions Terraform will take
terraform plan

# Applies the changes required to reach the desired state
terraform apply

# Destroys the infrastructure managed by Terraform
terraform destroy

# Displays the state or a plan with detailed information
terraform show

# State Management

# Lists all resources in the current state
terraform state list

# Shows the details of a specific resource in the state
terraform state show <resource>

# Removes a resource from the state file
terraform state rm <resource>

# Downloads the state from the remote backend
terraform state pull

# Uploads a local state file to the remote backend
terraform state push

# Resource and Module Management

# Marks a resource for recreation on the next apply
terraform taint <resource>

# Removes the taint from a resource (prevents recreation)
terraform untaint <resource>

# Imports an existing resource into Terraform management
terraform import <resource> <id>

# Manages multiple environments (workspaces)

# Lists all available workspaces
terraform workspace list

# Creates a new workspace
terraform workspace new <name>

# Switches to another workspace
terraform workspace select <name>

# Deletes an existing workspace
terraform workspace delete <name>

# Remote Backend Commands

# Authenticates with Terraform Cloud for remote operations
terraform login

# Logs out from Terraform Cloud and removes credentials
terraform logout

# Variables and Outputs

# Displays the output values defined in the Terraform configuration
terraform output

# Displays the outputs in JSON format
terraform output -json

# Opens an interactive console to evaluate expressions and debug
terraform console

# Provisioning and Debugging

# Updates the state file with the latest infrastructure information
terraform refresh

# Outputs a visual graph of resources and dependencies in DOT format
terraform graph

# Locking and Unlocking States

# Manually unlocks the state if locking is stuck
terraform force-unlock <lock-id>

# Best Practices and Advanced Techniques

# Use a .tfvars file for variables
terraform apply -var-file="prod.tfvars"

# Enable version locking for modules/providers
# Example:
provider "aws" {
  version = "~> 3.0"
}

# Use remote backends for state storage to avoid local state issues
# Example using S3 or Terraform Cloud
terraform init
