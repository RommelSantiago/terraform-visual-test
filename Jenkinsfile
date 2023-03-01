pipeline{
    agent {
        docker {
            image 'hashicorp/terraform:latest'
            label 'LINUX-SLAVE'
            args '--entrypoint="" -u root -v $PWD:/data -w /data'
        }
    }
    environment {
        AWS_DEFAULT_REGION="us-east-1"
    }
    stages{
        stage('Get variables'){
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]){
                sh '''
                aws --version
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
                   aws configure set aws_access_key_id $key --profile default
                   aws configure set aws_secret_access_key $secret --profile default
                   aws configure set default.region $AWS_DEFAULT_REGION
                   aws configure set id.region $AWS_DEFAULT_REGION
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
                   terraform init
                   plan
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