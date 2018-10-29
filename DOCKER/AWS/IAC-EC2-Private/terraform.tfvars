# Docker EE variables
###########################

# AWS
aws_region = "eu-west-1"
ami = "ami-0d063c6b"
deployment = "meetup42"

# Network Scheme
scheme_elb = "false"
scheme_subnets = "false"
scheme_ec2 = "false"

# ELB DNS
docker_ucp_lb = ""
docker_dtr_lb = ""

# EFS
efs_supported = "0"
efs_performance = "generalPurpose"

# Default Instance user
linux_user = "centos"
windows_user = "Admnistrator"

#Windows Instance Admin Password
windows_admin_password = ""

# EC2 Instance Type
linux_manager_instance_type = "t2.medium"
linux_worker_instance_type = "t2.medium"
linux_dtr_worker_instance_type = "t2.medium"
windows_worker_instance_type = "m4.medium"

# Authentication
key_name = "ydaniel"
key_path = "/Users/eggmuffin/.ssh/keys/AWS_Perso/ydaniel.pem"

# Network
remote_ssh_range = "0.0.0.0/0"
remote_access_range = "0.0.0.0/0"
vpc_ip_range = "172.30.0.0/16"
swarm_cidr = "172.30.0.0/22"
ucp_cidr = "172.30.4.0/22"
dtr_cidr = "172.30.8.0/22"
ext_cidr = "172.30.12.0/22"
pub_cidr = "172.30.16.0/25"

# s3
dtr_bucket_name = "dtr"
access_logs_bucket_name = "access-logs"

# Instances Count
linux_ucp_manager_count = 1
linux_ucp_worker_count = 1
linux_dtr_count = 1
windows_ucp_worker_count = 0

# EBS termination
delete_root_ebs = "true"
delete_data_ebs = "true"

# EBS Performance
ebs_optimized = "false"

# EBS Size
linux_manager_volume_system_size = "8"
linux_manager_volume_data_size = "8"
linux_worker_volume_system_size = "8"
linux_worker_volume_data_size = "8"
linux_dtr_worker_volume_system_size = "8"
linux_dtr_worker_volume_data_size = "8"
windows_worker_volume_system_size = "8"
windows_worker_volume_data_size = "8"

#UCP Informations
ucp_license_path = ""
ucp_admin_password = "admin"

# IAC Infos
ansible_inventory = "./inventory/1.hosts"
bootstrap_path = "./user-data.sh"
