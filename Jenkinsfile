pipeline {
    agent {
        docker { image 'php:5.6-cli-jessie' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'php --version'
            }
        }
    }
}
