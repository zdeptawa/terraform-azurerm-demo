# terraform-azurerm-demo
This is a simple Terraform AzureRM provider demo.

To deploy this on Azure, you will need to have environment variables set for
ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, and ARM_TENANT_ID.
You will also need to have the ssh key file created on your local system.

You will also need to generate a public and private key for use by the system.

## Generating public and private keys
```bash
$ ssh-keygen -t rsa -b 4096 -f tfaz_id_rsa
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in tfaz_id_rsa.
Your public key has been saved in tfaz_id_rsa.pub.
The key fingerprint is:
SHA256:vnc65Z6gIbT6pi+MIF+p2KtoDszEd3sPcl/13EIulzE nicj@Nics-MacBook-Pro.local
The key's randomart image is:
+---[RSA 4096]----+
|                 |
|                 |
|                 |
|.                |
| o . o. S    .E  |
|* . +..o    ooo+.|
|oB = oo+o .+. =o.|
|+.= o.=.+++.o+ . |
|=o..o*o o+.=o    |
+----[SHA256]-----+
```
Do not upload your private key files to a public location such as github

## Setting environment variables
The Terraform config requires certain variables to be set such as the subscription id for the provider and the public and private key information.

```bash
export TF_VAR_subscription_id="xxxxxxx"
export TF_VAR_client_id="xxxxxx"
export TF_VAR_client_secret="xxxxxx"
export TF_VAR_tenant_id="xxxxxxx"
export TF_VAR_ssh_key_private="$(cat ./tfaz_id_rsa)"
export TF_VAR_ssh_key_public="$(cat ./tfaz_id_rsa.pub)"
```

The private key corresponds to the public key in this repo **PLEASE DO NOT USE THIS KEY FOR PRODUCTION SYSTEMS**


Afterward, simply:

```bash
terraform init
terraform plan
terraform apply
```
