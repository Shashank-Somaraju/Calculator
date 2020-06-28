pipeline{
 	environment {
    	registry = "shashanksomaraju/calculator"
    	registryCredential ='Dockerhub'
    	dockerImage = ''
    	dockerImageLatest = ''
 	}
    agent any
    stages {
        stage('Stage I - Clone from github'){
            steps {
                git 'https://github.com/Shashank-Somaraju/Calculator.git'
            }
        }
        stage('Stage II - Build'){
            steps{
                sh 'mvn clean package'
            }
            post{
                success{
                    echo 'Built Successful'
                }
            }
        }
        
        stage('Stage III - Test') {
            steps {
                sh 'mvn test'
            }
            
            post {
                success {
                    echo 'Testing Successful'
                }
            }
        }
        stage('Stage IV - Make Docker Image & Push') {
            steps{
                script {
                    dockerImage=docker.build(registry)
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Stage V - Trigger Rundeck'){
            steps{
                script {
                    step([  $class: "RundeckNotifier",
                            includeRundeckLogs: true,
                            jobId: "dc87b5ef-269d-4e3b-831a-c5cb5999e679",
                            rundeckInstance: "rundeck_instance",
                            shouldFailTheBuild: true,
                            shouldWaitForRundeckJob: false,
                            tailLog: true])
                }
            }
        }
    }
    
}