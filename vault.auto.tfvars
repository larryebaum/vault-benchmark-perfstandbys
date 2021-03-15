#For Ubuntu, set unzip_command to "sudo apt-get install -y curl unzip"
#For RHEL, set unzip_command to "sudo yum -y install unzip"
unzip_command = "sudo yum -y install unzip"

# Ubuntu would be ami-759bc50a or ami-059eeca93cf09eebd
ami = "ami-6871a115" # RHEL 7.5
instance_type_vault  = "t2.micro"
instance_type_consul = "t2.micro"

key_name = "larryebaum"
vault_name_prefix = "larryebaum-benchmark-vault"
consul_name_prefix = "larryebaum-benchmark-consul"
vpc_id = "vpc-03e9af5aa624e650c"
subnets = "subnet-06b2354575ce443a7"

elb_internal = false
public_ip = true

vault_nodes = "3"
consul_nodes = "3"

# This downloads Vault Enterprise by default
vault_download_url = "https://s3-us-west-2.amazonaws.com/hc-enterprise-binaries/vault/ent/1.1.2/vault-enterprise_1.1.2%2Bent_linux_amd64.zip"

# This downloads Consul Enterprise by default
consul_download_url = "https://s3-us-west-2.amazonaws.com/hc-enterprise-binaries/consul/ent/1.5.0/consul-enterprise_1.5.0%2Bent_linux_amd64.zip"

# Used to auto-join Consul servers into cluster
auto_join_tag = "larryebaum-benchmark-cluster"

# These are only needed for HashiCorp SEs
owner = "larryebaum@hashicorp.com"
ttl = "4"
Name = "larryebaum"
se-region = "public-sector"
purpose = "perf_test"
terraform = "true"
creator = "larryebaum"
customer = "test"
tfe-workspace = "test"
lifecycle-action = "test"
