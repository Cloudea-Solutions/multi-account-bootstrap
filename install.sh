#!/bin/bash

# exit when any command fails
set -e

export AWS_PROFILE="bootstrap"

printf "\nStarting bootstrap process\n\n"

cd src/infrastructure

printf "Bootstrapping management account\n\n"

cd management

printf "Starting Terraform apply\n\n"
terragrunt run-all apply --terragrunt-source-update

cd ..

printf "Completed bootstrapping management account\n\n"

cd ../..
