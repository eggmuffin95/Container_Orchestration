These files allow to :

## Deploy a full AWS infrastructure from network items to instances using Terraform and provide an automatic ansible dynamic inventory

You can specify your own values in tfvars file.
## To deploy, run the following commands :

- ```terraform init```
- ```terraform plan -out=tfplan -input=false```
- ```terraform apply "tfplan"```

## Deploy a full Docker EE Orchestration Engine with UCP Master, DTR dedicated Workers Linux Workers and Windows Workers using Ansible

You can specify your own values in groupvars files.
To run installation, just send the following command :

- ```ansible-playbook --private-key=path/to/your/private/key -i inventory install.yml```
