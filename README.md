# Terraform Visual Asessment

This repository is intended to evaluate the terraform-visual tool as best completed as posible. 
The development branch has the most recent updates.

## Fundamentals
* It generates a visual report of the Terraform plan.
* It helps you to visualize the plan.
* It can be used on three different Ways:

On-line
Terraform Visual CLI
Docker

For the first two ways, refer to the official page: https://github.com/hieven/terraform-visual

## Docker Image Usage
The official documentation suggest the Docker Image usage on a pipeline. Nevertheless is does not have further documentation neither examples are provided. This repository shows how to use it.
The files are organized in a main terraform file which references two modules to provision an AWS VPC and an AWS EKS. It also has the variables terraform file and the Jenkins file for the pipeline.

The focus commands are shown below:
```
docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 init
docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 plan -var-file=vars.tfvars -out=plan.out
docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 show -json plan.out > plan.json
docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 --plan plan.json
```
The init, plan and show commands work fine, but the last one fails.
The prompt shows the basic terraform help. The command seems to not be recognized. So it is not possible to generate the visual report.

So, the recommendation is to use the CLI, which generates the visual report correctly.


### Further work
The next step is to get alert whenever an update of the docker image is available and/or new documentation is published.
