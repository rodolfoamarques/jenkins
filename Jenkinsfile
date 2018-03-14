pipeline {
    agent {
        docker { image 'php:5.6-cli-jessie' }
    }
    stages {
        stage('Build') {
            steps {
                echo 'composer install'
                sh 'mkdir -p bin && cd bin && curl -sS https://getcomposer.org/installer | php'
                sh 'cd ../'
                sh 'php bin/composer.phar --version'
                sh 'ls -al'
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
