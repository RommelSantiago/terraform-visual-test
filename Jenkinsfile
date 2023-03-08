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
                   /usr/local/bin/docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 --version
                   /usr/local/bin/docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 init
                   /usr/local/bin/docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 plan -var-file=vars.tfvars -out=plan.out
                   /usr/local/bin/docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 show -json plan.out > plan.json
                   /usr/local/bin/docker run --rm  -v $PWD:/data -w /data hieven/terraform-visual-cli:0.1.0-0.12.29 plan plan.json
                   open terraform-visual-report/index.html
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