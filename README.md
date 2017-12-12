# terraform-azurerm-demo

This is a simple Terraform AzureRM provider demo. In it's default state, this demo will use a mixture of modules from the [Terraform Module Registry for Azure](http://registry.terraform.io/browse?provider=azurerm&verified=true) and custom Terraform code to deploy a demo application with a publicly accessible frontend IP that consists of:

* an Azure Virtual Network (`10.0.0.0/16`)
* a public subnet within that Virtual Network (`10.0.1.0/24`)
* a private subnet within the Virtual Network (`10.0.2.0/16`)
* an Azure Load Balancer with a public IP
* an Azure Virtual Machine Scale Set (with three nodes in public subnet, private IPs only) running an application behind the load balancer
* a jumpbox/bastion server within the public network with a public IP
* Network Security Groups and rules necessary to allow HTTP traffic to the Scale Set/web tier as well as port 22 traffic for ssh to the jumpbox/bastion server
* a PostgreSQL database server in the private subnet with rules necessary for communication from public subnet/web tier
* a [demo application](https://github.com/nicholasjackson/gopher_search) created by [Nicolas Jackson](https://github.com/nicholasjackson) deployed to the multi-tier environment

Prerequisites
=============
Some prerequisites - you will need to have environment variables set for the following:

* `VAR_subscription_id`
* `VAR_client_id`
* `VAR_client_secret`
* `VAR_tenant_id`
* `VAR_ssh_key_private`
* `VAR_ssh_key_public`

To easily set these environment variables,  you can create and source a bash script. Here is an example of the contents:

```bash
export TF_VAR_subscription_id="xxxxxxx"
export TF_VAR_client_id="xxxxxx"
export TF_VAR_client_secret="xxxxxx"
export TF_VAR_tenant_id="xxxxxxx"
export TF_VAR_ssh_key_private="$(cat ./tfaz_id_rsa)"
export TF_VAR_ssh_key_public="$(cat ./tfaz_id_rsa.pub)"
```

You will also need to have the ssh key files created on your local system. By default, the ssh_key will be pulled from `~/.ssh/tfaz_id_rsa.pub`.

Generating Public and Private Keys
==================================
```bash
$ ssh-keygen -t rsa -b 4096 -f tfaz_id_rsa
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in tfaz_id_rsa.
Your public key has been saved in tfaz_id_rsa.pub.
The key fingerprint is:
SHA256:vnc65Z6gIbT6pi+MIF+p2KtoDszEd3sPcl/13EIulzE nicj@Nics-MacBook-Pro.local
The keys randomart image is:
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
Do not upload your private key files to a public location such as GitHub!


Deploying the Demo
==================
To deploy this on Azure, make sure you've got the prerequisites covered ([Terraform](https://www.terraform.io/) installed locally (at least version `0.11.1`), settings for `provider` and an ssh key in place). After that, it's a matter of performing the following:

1. Make sure that your prerequisites are in place and that your credentials work on Azure!
2. `git clone` this repository and change directory to it
3. Run `terraform init` within the repository folder to pull down modules and providers needed
4. Run `terraform plan` to see what changes it will make and double check there are no issues with the code
5. If you're happy with the changes that will be applied, run `terraform apply`
6. When prompted, type `yes` if you agree to continue
7. Your environment will be provisioned!

Once the nodes are healthy in the Load Balancer, you should be able to access the application via the public IP of the Load Balancer on `port 80`. You should also be able to access the jumpbox/bastion via ssh on `port 22` using the private key specified.

That's it! Use this code as a sample or extend it to fit your own needs! Thanks for checking out the demo! =]


Teardown
========
When you're ready to bring this infrastructure down, simply run `terraform destroy` in the repository folder (or the folder where the Terraform code/main.tf resides). ***BE SURE TO DOUBLE CHECK THE RESOURCES THAT WILL BE DESTROYED BY THIS COMMAND BEFORE TYPING `yes` TO CONTINUE!!!***


Special Thanks
==============
* [Ashley McNamara](https://github.com/ashleymcnamara) for her amazing [gopher images](https://github.com/ashleymcnamara/gophers) used by the [demo application](https://github.com/nicholasjackson/gopher_search)!


Authors
=======
* [Nicolas Jackson](https://github.com/nicholasjackson)
* [Zachary Deptawa](https://github.com/zdeptawa)
