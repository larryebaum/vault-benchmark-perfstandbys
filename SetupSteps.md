# Performance Testing Steps  
## Prerequisite
Export AWS access & secret access keys as environment variables. HashiCorp staff can pull these values from Doormat and paste into terminal session.  

## Setup Vault Cluster  
1. `mkdir ./perfTest; cd perfTest`  
1. `git clone https://github.com/larryebaum/vault-benchmark-perfstandbys; cd vault-benchmark-perfstandbys`  
1. Edit `vault.auto.tfvars` values for your environment  
1. Download & Unzip Terraform client v12.30 from https://releases.hashicorp.com/terraform/0.12.30/  
1. `./terraform init` (to init Terraform; download modules, etc.)  
1. `./terraform apply` (to begin build of perfTest cluster)  
`
    Apply complete! Resources: 53 added, 0 changed, 0 destroyed.  
    Outputs:  
    consul_address = larryebaum-benchmark-consul-elb-144276680.us-east-1.elb.amazonaws.com  
    vault_address = larryebaum-benchmark-vault-elb-1055158729.us-east-1.elb.amazonaws.com  
    vault_elb_security_group = sg-0cd0722e66160969b  
    vault_security_group = sg-0eeb5b3db48e92710
`
1. From AWS Console, note public IPs for 1 Consul node and all Vault nodes.  
1. SSH to Consul node  
1. `consul license put "<KEY>"` to apply license.  
1. `consul license get` to verify license applied and expiration date  
1. SSH to Vault 1st Vault node  
1. `export VAULT_ADDR="http://127.0.0.1:8200"; vault operator init -key-shares=1 -key-threshold=1` (note unseal key and root token values)  
1. `export VAULT_ADDR="http://127.0.0.1:8200"; export VAULT_TOKEN="<TOKEN>"; vault operator unseal "<KEY>"; vault write /sys/license "text=<LICENSE>"`  
1. `vault read /sys/license` to verify license applied and expiration date  
1. Repeat two steps above to apply and verify license on each remaining Vault node  
1. View URL vault address, with ":8200" appended to end.  
1. Login with vault token  
1. Click Enable new engine, select Transit, click Next, rename 'transitTest', click Enable Engine.  
1. Click into 'transitPerfEngine', click Create encryption key, rename 'test', click Create encryption key  

## Setup Performance Test Node  
1. From AWS console, select Vault node, select Actions > Launch More Like This, review configurations, edit Name tag to clearly identify as WRK node, Launch node.
1. From AWS console, select security group outbound rules and edit to allow 'all open' (easier than figuring out all of ports used by wrk)
1. SSH to WRK node
1. `export VAULT_ADDR="http://<VAULT_ADDRESS>:8200"; export VAULT_TOKEN="<TOKEN>"`
1. `sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm`
1. `sudo yum install -y https://extras.getpagespeed.com/release-el7-latest.rpm`
1. `sudo yum groupinstall -y 'Development Tools'`
1. `sudo yum install -y openssl-devel`
1. `sudo yum install -y git`
1. `git clone https://github.com/wg/wrk.git`
1. `cd wrk; make`
1. `git clone https://github.com/larryebaum/vault-benchmarking`
1. `sudo cp wrk /usr/local/bin`
1. `cd ./vault-benchmarking`
1. `vi ./encrypt-transit.lua`
    edit `local transitPayloadLength = 1024` to 128

## Performance Test / Tuning
1. SSH to Vault node from separate terminal and run top to monitor CPU
1. CPU may peak at maximum (efficient encryption) 
1. On WRK node wrk -t4 -c16 -d60s -H "X-Vault-Token: $VAULT_TOKEN" -s encrypt-transit.lua $VAULT_ADDR/v1/transitTest/encrypt/test encrypts=500000
1. Tuning:
    1. Adjust string length to encrypt:
    1. vi ./encrypt-transit.lua
    1. edit local transitPayloadLength = 1024 to shorter/longer value
1. Adjust concurrent threads with -t value, connections with -c value, duration with -d value, and quantity of encrypts. Longer tests better account for fluctuations.
