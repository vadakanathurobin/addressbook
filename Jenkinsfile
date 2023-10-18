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
        DEV_SERVER="ec2-user@172.31.34.81"
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
            agent {
                label 'linux_slave'
            }
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
                    sh "scp -o StrictHostKeyChecking=no server-config.sh ${DEV_SERVER}:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER} 'bash ~/server-config.sh'"
                    }
                }
            }
        }        
        
    }
}
