# Laboratorio

This repository is intended to get the first steps and evolve from it, to achieve the laboratory as best completed as posible. 
Two branches have been added to the repo; The development branch is the one that has the most recent updates.

## Setup
The first step is to get started with a local installation for Jenkins. You can view
an example in this repository using Docker Compose:
```
https://github.com/RommelSantiago/jenkins
```

Once you have set the local Jenkins, create a job as suggested:
1. Go to Jenkins Dashboard and click on New Item.
2. Configure a pipeline to get the Jenkinsfile from the repo.
   In the pipeline section, choose Pipeline script from SCM and set the access.
   In SCM, choose Git
   Then choose the user/pasword secret (previously set as global credential, type user-password) for accesing the repo.
3. Manage Jenkins to install aws-credentials plugin.
4. Manage Jenkins to setup a new global credential, choose aws credentials and set the secrets from the aws account.
5. Run the job.

## Terraform integration
W I P

I tried to use the terraform tool/plugin as part of Jenkins, but it seems not to work in Windows.

So, an easy way to get terraform workin from Jenkins, Download the zip and then copy the file in the local volume, then, inside the container, move the file from the container volume to /usr/local/bin. Verify with # terraform -v and got the version.
Then from jenkins I prompted the version and it was printed in the console, so it is a way to easy use terraform in the job.

Until now, the pipeline has a simple terraform file to provision an instance. The pipeline executes the format, init, validate and plan succesfully.

### Further work
The next step is to follow the best practices of a terraform project to hold the infra architecture that solves the laboratory.