pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                ruby -v
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
