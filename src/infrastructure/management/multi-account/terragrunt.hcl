include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:rail-cloud-formation/onsite-infrastructure-modules.git//src/multi-account?ref=v0.1.18-alpha"
}

inputs = {
  accounts = [
    {
      name  = "SharedServices"
      number = "387189086206"
    },
    {
      name  = "Dev"
      number = "625395662669"
    },
    {
      name  = "Test"
      number = "714772080371"
    },
    {
      name  = "Prod"
      number = "052082578542"
    }
  ]
  bootstrap_user_name   = "bootstrap"
  bootstrap_policy_name = "BootstrapAccessPolicy"

  member_account_organization_role_name = "OrganizationAccountAccessRole"
}
