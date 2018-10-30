IAC-EC2-Public project allows to :

# Deploy a full AWS infrastructure from Network items to Instances through Load Balancers using Terraform and provide automatically a dynamic Ansible compatible inventory.

## You can specify your own values in tfvars file.

By example, you could change the instances count, the maximum and minimum values for auto-scaling groups, the EC2 Instances Types, Disks Sizes and extra datas as password, usernames, etc...

## To deploy your infrastructure, run the following commands :

- ```terraform init```
- ```terraform plan -out=tfplan -input=false```
- ```terraform apply "tfplan"```

Despite this Docker Platform is intended for Public use, keep in mind though that you should adapt the security groups values to prevent the platform from being reachable worldwide.

NB: The built-in Terraform Inventory module does not work with Auto-Scaling Groups due to the fact it can not retrieve IPs and IDs from auto-scaled instances. A workaround script is in working in progress to provide this inventory. For now, you could launch your AWS infrastructure but not deploy Docker using Ansible except it you chose to provide instances IPs and IDs manually in the inventory host file.

# Deploy a full Docker EE Orchestration Platform with UCP Masters, DTR dedicated Workers, Linux Workers and Windows Workers using Ansible.

## You should specify your own values in groupvars files for the Docker EE version to setup by example or simply to fill up your Docker Subscription ID.
## To run the installation process, just send the following command :

- ```ansible-playbook --private-key=path/to/your/private/key -i inventory install.yml```

Other playbooks are available in this project path and allow you to update or uninstall your Docker EE platform.

Despite you may change several AWS items network scheme, IAC-EC2-Public is intended for deploying a public reachable Docker Platform.

Changing these values could bring failures especially during the Docker Installation process.
Indeed, during the DTR setup, the DTR instance must reach the UCP Manager using its public IP.

For internal purpose, the project IAC-ASG-Private is in working in progress.
