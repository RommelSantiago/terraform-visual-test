pipeline{
    agent any
    environment {
        AWS_DEFAULT_REGION="us-east-1"
    }
    stages{
        stage('Get variables'){
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]){
                sh '''
                /usr/local/bin/aws --version
                awskey=$AWS_ACCESS_KEY_ID
                awssecret=$AWS_SECRET_ACCESS_KEY
                echo $awskey > awskey
                echo $awssecret > awssecret
                '''
                }
            }
        }
        stage ( 'Configure AWS CLI' ) {
            steps {
                sh '''
                   #!/bin/sh -e\n
                   set +x
                   key=$(cat awskey)
                   secret=$(cat awssecret)
                   /usr/local/bin/aws configure set aws_access_key_id $key --profile default
                   /usr/local/bin/aws configure set aws_secret_access_key $secret --profile default
                   /usr/local/bin/aws configure set default.region $AWS_DEFAULT_REGION
                   /usr/local/bin/aws configure set id.region $AWS_DEFAULT_REGION
                   rm awskey
                   rm awssecret
                   echo 'working directory:' 
                   pwd
                   ls -la
                   echo 'whoami'
                   whoami
                '''   
            }
        }
        stage('Terraform Plan'){
            steps {
                sh '''
                   /usr/local/bin/docker --version
                   /usr/local/bin/docker run --rm  -v $PWD:/data -w /data hashicorp/terraform:latest init
                   /usr/local/bin/docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 plan
                '''
            }
        }
        stage('Deploy'){
            when {
                branch 'qa'
            }
            steps {
                sh '''
                terraform apply --auto-aprove
                '''
            }
        }
    }
    post {
        success { 
            sh 'echo Completed...'
        }
        failure {
            sh 'Something went wrong'
        }
        /*cleanup {
            sh 'rm -rf *'
        }*/
    }
}