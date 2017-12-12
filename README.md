# terraform-azurerm-demo
This is a simple Terraform AzureRM provider demo.

To deploy this on Azure, you will need to have environment variables set for
ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, and ARM_TENANT_ID.
You will also need to have the ssh key file created on your local system.

```bash
export TF_VAR_subscription_id="xxxxxxx"
export TF_VAR_client_id="xxxxxx"
export TF_VAR_client_secret="xxxxxx"
export TF_VAR_tenant_id="xxxxxxx"
export TF_VAR_ssh_key_private="-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAqeOocoOal68M6r6H6FHK4fJA7DS42v5cw06MwVTCoYEm/LAe
AEkS1VIx5Ly5hGr7h6Fl7m2TFNp8h918c+8hgzecHrK/3dxhIEQtqUUVGanKbdu5
Ge4XFBgmuvY+1v88VIkBBuz4MpSMErieq1c4agjAB2ql0t0ZbN1HaVCn/PkVx35r
iw9DWMpz8PauIFGdBJlzNBengxxkskiOeTYr+M4cz/Y3Bgd7Ql/aNjgdj22coSXI
nC9z7KT6M4dSt90FnJKIpV3JZexSaE68imjaYPU52VmKkzhgB9CRzl2R6ZZIIDHJ
XlIHEA7592DtDLsrDEyzy9dkZYJ5TCREjd5+5wIDAQABAoIBAEDGiMeA3kTPfcFT
fEZcSVr1H0Pwpjr5mSzumkRsqPkjYVYfYJEDS6cCe/uW6bVPhTAlndPW+6mL1MeI
75bUqpZ5cZFS3k0dZfsDg9VyfaUXVBOnH2B/o1UKEFpg4XzgPISO6FFXsRq4AOBy
fC0gSGZFh9JMG4XWv4b+p+fD1Qli4EpAr/pdPSeZuEoDdGFQHm152Q2xzyrFdki2
u43nuFgD8j9K8CjMgXEvz3f0dhkDh0LakvtsvVpQw7RlR+A6HgiluWxvZFrws0U8
5uUv62pCq3OzvBHr08xdoeiOG/N7osyd+ln3AkomtU+kNCcM3KKx67s6ulTtYiB5
bfE1zCECgYEA3m0P7NbVeAN+2M8abfthJ5CkqVjchktIfWzpm5NKFuqJbKi2yHQ6
LXFRBMVi2UKAxNjB6b/ikEpPKCrDNY5KXV1TFxe0SYVGTQoaRGDZniJ2xm889Zl9
Py+3VzlNWtTA+C2gs1XeTkvxV0LqYQ+2MDa94in/BcCjrEmLtJMVnr0CgYEAw4h7
leiA26JuPCTlPddxDj/zPxAbPR6Jbro8CAl//u3usIepKkJV6EBth/NaonTnmD1o
xPDf/40Li2oVKz5zvEH+9hm45lgC8LHCv9r4/2hvjsO+FcxzEYQI2spWNAhWs+T0
GoAZRumklk4UkQlYDIBAxMs1n5mvj5qDGvSj8HMCgYBPkeqRiqVhQrbdLvHAiJ5P
/iG55200qbfsDstfeYiWvB6ffZeuDE5HtXMLZuWe3XidcwGj8p5Fih/ZObsN7LJT
xjAUYcmAR6pHoyaUcaVIOgINqPvAzMEOmq5XCMvQg63o2sHThhN6JRbYZbrdMDa3
9s1lHCr8Ttb+qmzNE5U3bQKBgGSx5qMepy10irxia8PbLRefi08QplZlYXUqZzvk
WIwaT++NDWr72m3OsBlxE13SQmo+RbQWL+TU5/sV2Gz6rnNmsTxfpr7I2ErH4HkY
9V3ilIC7ASsMrL16d2zlAlutZ6kg4Sy8h0fjjqTw9Np0K2nUqoYt+CGG7chQU/AP
yFVNAoGBAMzATIdrUlabNdNQjmLtw2O669Yt2d42NX2BLKlt2ch5YVOdg3chmjn4
/FHgH6QJ84xjShOzNcCQHn6JwfZHl1sGZ8yyd7w3HG50iniclRb+EoaNJJ5d+e4e
GXl7e2Qg6SpXbM49RC9Wz+H9wjvnGu3K6Ashn8cvzDQhfFz7v/+2
-----END RSA PRIVATE KEY-----"
```

The private key corresponds to the public key in this repo **PLEASE DO NOT USE THIS KEY FOR PRODUCTION SYSTEMS**


Afterward, simply:

```bash
terraform init
terraform plan
terraform apply
```
