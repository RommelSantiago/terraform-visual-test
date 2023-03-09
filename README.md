# Terraform Visual Asessment

This repository is intended to evaluate the terraform-visual tool as best completed as posible. 
The development branch has the most recent updates.

## Fundamentals
– It generates a visual report of the Terraform plan.
– It helps you to visualize the plan.
– It can be used on three different  
   Ways:

On-line
Terraform Visual CLI
Docker

For the first two ways, refer to the official page: [https://github.com/hieven/terraform-visual](Terraform Visual)

## Docker Image Usage
The official documentation suggest the Docker Image usage on a pipeline. Nevertheless is does not have further documentation neither examples are provided. This repository shows how to use it.
The files are organized in a main terraform file which references two modules to provision an AWS VPC and an AWS EKS. It also has the variables terraform file and the Jenkins file for the pipeline.

The focus commands are shown below:
'''
code here
'''

### Further work
The next step is to get alert whenever an update of the docker image is available and/or new documentation is published.
