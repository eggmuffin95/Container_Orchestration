# Docker EE variables
###########################

# AWS
aws_region = "eu-west-1"
efs_supported= 1
vpc_ip_range = "172.30.0.0/16"
remote_ssh_range = "0.0.0.0/0"
remote_access_range = "0.0.0.0/0"
deployment = "Docker-EE-LAB"

# Authentication
key_name = "ydaniel"
key_path = "/Users/eggmuffin/.ssh/keys/AWS_Perso/ydaniel.pem"

# Instances Details
ami = "ami-0d063c6b"
linux_user = "centos"
windows_user = "Admnistrator"
linux_manager_instance_type = "m4.large"
linux_worker_instance_type = "m4.large"
linux_dtr_instance_type = "m4.large"
windows_worker_instance_type = "m4.large"
manager_cluster_size = 3
worker_cluster_size = 1
worker_dtr_cluster_size = 3
windows_worker_cluster_size = 0
max_autoscaled_managers_size = 3
max_autoscaled_workers_size = 3
max_autoscaled_workers_dtr_size = 3
max_autoscaled_windows_workers_size = 0
linux_manager_volume_size = "30"
linux_worker_volume_size = "30"
linux_dtr_worker_volume_size = "30"
windows_worker_volume_size = "30"

# IAC Infos
ansible_inventory = "./inventory/1.hosts"
bootstrap_path : "./install-docker.sh"
