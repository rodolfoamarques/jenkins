pipeline {
    agent {
        docker { image 'prooph/composer:5.6' }
    }
    stages {
        stage('Build') {
            steps {
                echo 'composer install deps'
                sh 'composer update'
            }
        }
        stage('Test') {
            steps {
                sh 'php --version'
                echo 'phpunit starting'
                sh 'composer run-script test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'capistrano'
            }
        }
    }
}
