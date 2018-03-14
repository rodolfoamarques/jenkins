node {
    stage 'checkout repo'
    checkout scm

    stage 'build'
    docker.image('php:5.6-cli-jessie').withRun('') { c ->
        echo 'install git'
        sh 'apt-get update && apt-get install -y git'
        echo 'composer install'
        sh 'mkdir -p bin && cd bin && curl -sS https://getcomposer.org/installer | php'
        sh 'cd ../'
        sh 'php bin/composer.phar --version'
        sh 'php bin/composer.phar install'
        sh 'ls -al'
    }

    stage 'test'
    docker.image('mysql:5').withRun('-e "MYSQL_ROOT_PASSWORD=my-secret-pw"') { c ->
        docker.image('mysql:5').inside("--link ${c.id}:db") {
            /* Wait until mysql service is up */
            echo 'waiting for mysql service to start'
            sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'
            sh 'ls -al'
        }
        docker.image('php:5.6-cli-jessie').inside("--link ${c.id}:db") {
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
