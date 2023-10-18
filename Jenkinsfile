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
            agent {
                label 'linux_slave'
            }
            steps {
                script{
                sh "mvn package"
                }
            }
        }        
        
    }
}
