pipeline {
    agent any

    parameters{
        string(name:"Env",defaultValue:"Test",description:"env to compile")
        booleanParam(name:'testExecute',defaultValue:true,description:'Execute Test Cases')
        choice(name:'APPVERSION',choices:['1.0'.'1.1','1.2'])
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
                    params.testExecute == true
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
                echo 'Package Version ${params.APPVERSION}'
                }
            }
        }        
        
    }
}
