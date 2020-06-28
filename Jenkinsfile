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
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Stage IV - Make Docker Image') {
            steps{
                script {
                    dockerImage=docker.build(registry)
                }
            }
        }
        stage('Stage V - Push Docker Image') {
            steps{
                script {
                      docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        
        stage('Stage VI - Trigger Rundeck'){
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