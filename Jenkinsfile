pipeline {
    agent {
        docker { image 'php:5.6-cli-jessie' }
    }
    stages {
        stage('Build') {
            steps {
                echo 'composer install'
            }
        }
        stage('Test') {
            steps {
                sh 'php --version'
                echo 'phpunit'
            }
        }
        stage('Deploy') {
            steps {
                echo 'capistrano'
            }
        }
    }
}
