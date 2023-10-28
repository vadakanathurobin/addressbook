pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    parameters{
        string(name:"Env",defaultValue:"Test",description:"env to compile")
        booleanParam(name:"executeTests",defaultValue:true,description:"Decide to execute test cases")
        choice(name:"AppVersion",choices:['1.0','1.1','1.2'])
    }

    environment{
        DEV_SERVER="ec2-user@172.31.7.83"
        DEPLOY_SERVER="ec2-user@172.31.6.244"
        IMAGE_NAME='vadakanathurobin/myprivaterepo'
    }
    stages {
        
        stage('Compile') {
            agent any
            steps {
                script{
                sh "mvn compile"
                }
            }
        }
        stage('UnitTest') {
            agent any
            // agent {
            //     label 'linux_slave'
            // }
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                script{
                sh "mvn test"
                }
            }
            post{
                always{
                    junit "target/surefire-reports/*.xml"
                }
            }
        }
        stage('Package') {
            agent any
            steps {
                script{
                    sshagent(['aws-linux-server-keypair']) {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerpassword', usernameVariable: 'dockerusername')]) {

                        sh "scp -o StrictHostKeyChecking=no server-config.sh ${DEV_SERVER}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER} 'bash ~/server-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"
                        sh "ssh ${DEV_SERVER} sudo docker login -u ${dockerusername} -p ${dockerpassword}"
                        sh "ssh ${DEV_SERVER} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                        }
                    }
                }
            }
        }        
        stage('Deploy') {
            agent any
            steps {
                script{
                    sshagent(['aws-linux-server-keypair']) {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerpassword', usernameVariable: 'dockerusername')]) {

                        sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER} sudo yum install docker -y"
                        sh "ssh ${DEPLOY_SERVER} sudo systemctl start docker"
                        sh "ssh ${DEPLOY_SERVER} sudo docker login -u ${dockerusername} -p ${dockerpassword}"
                        sh "ssh ${DEPLOY_SERVER} sudo docker run -itd -P ${IMAGE_NAME}:${BUILD_NUMBER}"
                        }
                    }
                }
            }
        }    

        
    }
}
