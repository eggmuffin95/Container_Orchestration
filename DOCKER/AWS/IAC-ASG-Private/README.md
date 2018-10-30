IAC-ASG-Private project allows to :

# Deploy a full AWS infrastructure from Network items to Auto-Scaled Instances through Load Balancers using Terraform and provide automatically a dynamic Ansible compatible inventory.

## You can specify your own values in tfvars file.

By example, you could change the clustered instances count, the EC2 Instances Types, Disks Sizes and extra datas as password, usernames, etc...

## To deploy your infrastructure, run the following commands :

- ```terraform init```
- ```terraform plan -out=tfplan -input=false```
- ```terraform apply "tfplan"```

Because this AWS platform is intended for private use, you should first deploy a bastion instance able to reach the Docker EE Instances from which you should pull this project and launch your commands.  

# Deploy a full Docker EE Orchestration Platform with UCP Masters, DTR dedicated Workers, Linux Workers and Windows Workers using Ansible.

## You should specify your own values in groupvars files for the Docker EE version to setup by example or simply to fill up your Docker Subscription ID.
## To run the installation process, just send the following command :

- ```ansible-playbook --private-key=path/to/your/private/key -i inventory install.yml```

Other playbooks are available in this project path and allow you to update or uninstall your Docker EE platform.

Note that deploying more than one UCP Manager and/or DTR Worker will automatically provide a primary and secondary UCP Managers. For the DTR, it will deploy one DTR Master instance and replicas. 

Despite you may change several AWS items network scheme, IAC-EC2-Pricate is intended for deploying a private only Docker Platform.

Changing these values could bring failures especially during the Docker Installation process.
Indeed, during the DTR setup, the DTR instance must reach the UCP Manager using its private IP.

For public purpose, the project IAC-EC2-Public is the one to use. A IAC-ASG-Public project will be created later.


NB: Considering this project, Terraform part is ready to use however there are still missing adaptions to work on the Ansible part. Stay tuned for updates considering it.
