# Docker EE variables
###########################
region = "eu-west-1"
efs_supported= 1
vpc_cidr = "172.30.0.0/16"
deployment = "Docker-EE-LAB"
key_name = "YD-AWS-KEY"
private_key_path = "/Users/eggmuffin/.ssh/YD-AWS-LAB-LBN.pem"
linux_ucp_manager_count = 3
linux_ucp_worker_count = 1
linux_dtr_count = 3
windows_ucp_worker_count = 0
windows_user = "Admnistrator"
linux_user = "centos"
ansible_inventory = "./inventory/1.hosts"
