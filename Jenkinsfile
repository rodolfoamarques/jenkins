pipeline {
    agent {
        docker { image 'php:5.6-cli-jessie' }
    }
    stages {
        stage('Build') {
            steps {
                echo 'composer install'
                sh 'mkdir bin && cd bin && curl -sS https://getcomposer.org/installer | php'
                sh 'composer.phar --version'
                sh 'cd ../ && ls -al'
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
