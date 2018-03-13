pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                php -v
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
