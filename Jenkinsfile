pipeline {
    agent any

    parameters{
        string(name:"Env",defaultValue:"Test",description:"env to compile")
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

            steps {
                script{
                echo 'UnitTest'
                }
            }
        }
        stage('Package') {
            steps {
                script{
                echo "Package Version"
                }
            }
        }        
        
    }
}
