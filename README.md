# Heroku Vault Starter

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://dashboard.heroku.com/new?template=https%3A%2F%2Fgithub.com%2Feshishkin%2Fheroku-vault-starter%2Ftree%2Fmaster)

This is a simple starter script that runs [Hashicorp Vault](https://www.vaultproject.io/) on Heroku server. The code is based on [this](https://github.com/pallavkothari/vault) repository 
with a couple of features.

The script downloads Vault, installs it and configures Postgres DB to work with Vault.

Since Vault by default is in sealed state, it is not possible to extract data from it. The script tries to solve such problem. If `VAULT_UNSEAL_KEY` enviromental 
variable is set, the script will try to unseal Vault at startup.



__Warning__: This approach is fine for pet projects, but is not production ready solution. Vault itself provides feature for auto unsealing, and 
it is based on cloud KMS. See https://learn.hashicorp.com/vault/day-one/ops-autounseal-aws-kms for more details

How to use it 

- Use [this](https://dashboard.heroku.com/new?template=https%3A%2F%2Fgithub.com%2Feshishkin%2Fheroku-vault-starter%2Ftree%2Fmaster) or a button above to install
Vault on Heroku server (it uses free plan by default)
- When Vault is installed open your vault client and perform the following commands
  ```
  export VAULT_ADDR='LINK_TO_VAULT'
  vault operator init -key-shares=1 -key-threshold=1
  ```
- Save root token and unseal key somewhere
- If you need autounsealing feature, set `VAULT_UNSEAL_KEY` variable in Heroku console
