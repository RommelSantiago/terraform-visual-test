# Laboratorio

This repository is intended to hold the resources to get the laboratory completed.

## Setup
The first step is to get started with a local installation for Jenkins. You can view
an example in this repository using Docker Compose:
```
https://github.com/RommelSantiago/jenkins
```

Once you have set the local Jenkins, create a job as suggested:
1. Go to Jenkins Dashboard and click on New Item.
2. Configure a pipeline to get the Jenkinsfile from the repo.
3. Manage Jenkins to install aws-credentials plugin.
4. Manage Jenkins to setup a new global credential, choose aws credentials and set the secrets from the aws account.
5. Run the job.

## Terraform integration
W I P