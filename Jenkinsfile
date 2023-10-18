pipeline {
    agent none

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
        }
        stage('Package') {
            agent any
            steps {
                script{
                sh "mvn package"
                }
            }
        }        
        
    }
}
