node {
    stage 'checkout repo'
    checkout scm

    docker.image('mysql:5.6').withRun('-e "MYSQL_ROOT_PASSWORD=mysql"') { c ->
        docker.image('mysql:5.6').inside("--link ${c.id}:db") {
            /* Wait until mysql service is up */
            stage 'start mysql'
            echo 'waiting for mysql service to start'
            sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'
        }
        docker.image('php:5.6-cli-jessie').inside("--link ${c.id}:db") {
            echo 'install git'
            sh 'apt-get update && apt-get install -y git'

            echo 'composer install'
            sh 'mkdir -p bin && cd bin && curl -sS https://getcomposer.org/installer | php'
            sh 'cd ../'
            sh 'php bin/composer.phar --version'

            echo 'install composer libs'
            sh 'php bin/composer.phar install'

            echo 'running phpunit'
            sh './vendor/bin/phpunit --version'
        }
    }

    stage 'deploy'
    docker.image('ruby:2.5.0').withRun('') { c ->
        echo 'installing bundler'
        sh 'gem install bundler'
        sh 'bundle install'
        sh 'ls -al'
    }
}
