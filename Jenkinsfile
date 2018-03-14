pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                ruby -v
                node -v
                npm -v
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
