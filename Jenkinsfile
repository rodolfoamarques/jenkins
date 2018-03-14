pipeline {
    agent {
        docker { image 'php:5.6-cli-jessie' }
    }
    stages {
        stage('Build') {
            steps {
                echo 'install git'
                sh 'apt-get update && apt-get install -y git'
                echo 'composer install'
                sh 'mkdir -p bin && cd bin && curl -sS https://getcomposer.org/installer | php'
                sh 'cd ../'
                sh 'php bin/composer.phar --version'
                sh 'ls -al'
                sh 'whoami'
                sh 'php bin/composer.phar install'
            }
        }
        stage('Test') {
            steps {
                sh 'php --version'
                echo 'phpunit'
                sh './vendor/bin/phpunit --version'
            }
        }
        stage('Deploy') {
            steps {
                echo 'capistrano'
            }
        }
    }
}
