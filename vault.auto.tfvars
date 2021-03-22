#For Ubuntu, set unzip_command to "sudo apt-get install -y curl unzip"
#For RHEL, set unzip_command to "sudo yum -y install unzip"
unzip_command = "sudo yum -y install unzip"

# Ubuntu would be ami-759bc50a or ami-059eeca93cf09eebd
ami = "ami-6871a115" # RHEL 7.5
#instance_type_vault  = "t2.micro"
#instance_type_consul = "t2.micro"
instance_type_vault  = "m5.xlarge"
instance_type_consul = "m5.xlarge"

key_name = "larryebaum-hashi-aws"
vault_name_prefix = "larryebaum-benchmark-vault"
consul_name_prefix = "larryebaum-benchmark-consul"

elb_internal = false
public_ip = true

vault_nodes = "3"
consul_nodes = "3"

# This downloads Vault Enterprise by default
vault_download_url = "https://releases.hashicorp.com/vault/1.6.3+ent/vault_1.6.3+ent_linux_amd64.zip"

# This downloads Consul Enterprise by default
consul_download_url = "https://releases.hashicorp.com/consul/1.9.4+ent/consul_1.9.4+ent_linux_amd64.zip"

# Used to auto-join Consul servers into cluster
auto_join_tag = "larryebaum-benchmark-cluster"

# These are only needed for HashiCorp SEs
owner = "larryebaum@hashicorp.com"
ttl = "-1"

vault_elb_health_check = "HTTP:8200/ui/"
