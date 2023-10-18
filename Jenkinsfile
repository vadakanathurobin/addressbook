pipeline {
    agent any

    parameters{
        string(name:"Env",defaultValue:"Test",description:"env to compile")
        booleanParam(name:"executeTests",defaultValue:true,description:"Decide to execute test cases")
        choice(name:"AppVersion",choices:['1.0','1.1','1.2'])
    }
    stages {
        
        stage('Compile') {
            steps {
                script{
                echo 'Compile'
                echo "Compile in env : ${params.Env}"
                }
            }
        }
        stage('UnitTest') {
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                script{
                echo 'UnitTest'
                }
            }
        }
        stage('Package') {
            steps {
                script{
                echo "Package Version ${params.AppVersion}"
                }
            }
        }        
        
    }
}
