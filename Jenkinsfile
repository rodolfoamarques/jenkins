pipeline {
    agent {
        docker { image 'prooph/composer:5.6' }
    }
    stages {
        stage('Build') {
            steps {
                echo 'composer install deps'
                sh 'composer --version'
            }
        }
        stage('Test') {
            steps {
                sh 'php --version'
                echo 'phpunit starting'
            }
        }
        stage('Deploy') {
            steps {
                echo 'capistrano'
            }
        }
    }
}
