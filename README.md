# Bootstrap Multi-Account Environment

This project bootstraps a set of member accounts in an existing AWS Organization via the management account. It then creates a role in the management account with a policy that grants permission to assume a role called `OrganizationAccountAccessRole` in each of the member accounts that were created.

This process relies on the fact that when a member account is created it is automatically set up with the `OrganizationAccountAccessRole` role and the required trust relationship to the management account. For more information see [Accessing a member account that has a management account access role](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_access.html#orgs_manage_accounts_access-cross-account-role) in the AWS Organizations documentation.

Once the member accounts have been created and the trust relationship between the management and member accounts has been established, the management account's bootstrapping role can be used by separate Terragrunt/Terraform projects to bootstrap resources in each of the member accounts. For example, one might bootstrap a CI/CD pipeline into a shared services account and set up the necessary roles and policies in a dev/test/prod account.

## Configuration

### Management Account

The details of the management account and in which region to create the remove state can be configured in `common_vars.yaml`.

```
management_account_id: "123456789012"   // the account ID of the management account
management_account_name: "Management"   // the account name of the management account

remote_state_region: "ap-southeast-2"   // the region in which to store the remote state
```

### Bootstrapped Resources

The details of the accounts and the bootstrapping role and policy can be configured in the `multi-account` project's `terragrunt.hcl` file.

## Installation

### Pre-requisites

1. Create an AWS account that represents the Management account in the AWS Organization.
2. Enable the AWS Organization service.
3. Create four member accounts: Shared Services, Dev, Test and Prod.
4. Provide the account names and account numbers in `accounts` variable in the `multi-account\terragrunt.hcl` file.
5. Create a user called `bootstrap` in the Management account and assign an access policy to that user allowing the following:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket", "s3:GetObject", "s3:PutObject"],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "*"
    }
  ]
}
```