#For Ubuntu, set unzip_command to "sudo apt-get install -y curl unzip"
#For RHEL, set unzip_command to "sudo yum -y install unzip"
unzip_command = "sudo yum -y install unzip"

# Ubuntu would be ami-759bc50a or ami-059eeca93cf09eebd
ami = "ami-6871a115" # RHEL 7.5
instance_type_vault  = "t2.micro"
instance_type_consul = "t2.micro"

key_name = "mattpeters"
vault_name_prefix = "mattspeters-benchmark-vault"
consul_name_prefix = "mattspeters-benchmark-consul"
vpc_id = "vpc-04c2ab7097c6cea2c"
subnets = "subnet-004b0106fca7dea1c"

elb_internal = false
public_ip = true

vault_nodes = "3"
consul_nodes = "5"

# This downloads Vault Enterprise by default
vault_download_url = "https://s3-us-west-2.amazonaws.com/hc-enterprise-binaries/vault/ent/1.1.2/vault-enterprise_1.1.2%2Bent_linux_amd64.zip"

# This downloads Consul Enterprise by default
consul_download_url = "https://s3-us-west-2.amazonaws.com/hc-enterprise-binaries/consul/ent/1.5.0/consul-enterprise_1.5.0%2Bent_linux_amd64.zip"

# Used to auto-join Consul servers into cluster
auto_join_tag = "matts-benchmark-cluster"

# These are only needed for HashiCorp SEs
owner = "mpeters@hashicorp.com"
ttl = "-1"
