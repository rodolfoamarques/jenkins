node {
    stage 'checkout repo'
    checkout scm

    stage 'start services'
    docker.image('mysql:5.6').withRun('-e "MYSQL_ROOT_PASSWORD=mysql"') { c ->
        docker.image('mysql:5.6').inside("--link ${c.id}:db") {
            /* Wait until mysql service is up */

            echo 'waiting for mysql service to start'
            sh 'while ! mysqladmin ping -h db --silent; do sleep 1; done'
            sh 'mysqladmin -u root -pmysql -h db create test'
            sh 'mysql -u root -pmysql -h db -e "show databases;"'
        }
        docker.image('php:5.6-cli-jessie').inside("--link ${c.id}:db") {
            stage 'install dependencies'
            sh 'apt-get update && apt-get install -y git zip unzip ssh-client'
            sh 'mkdir -p bin && cd bin && curl -sS https://getcomposer.org/installer | php'
            sh 'cd ../'
            sh 'php bin/composer.phar --version'

            stage 'install composer dependencies'
            sh 'php bin/composer.phar install'

            stage 'run tests'
            echo 'running phpunit'
            sh './vendor/bin/phpunit --version'
        }
    }

    stage 'prepare deployment'
    docker.image('ruby:2.5.0').withRun('') { c ->
        echo 'installing bundler'
        sh 'gem install bundler'
        sh 'bundle install'

        if (env.BRANCH_NAME == 'master') {
             stage 'deploy to production'
             echo 'bundle exec cap production deploy'
        }

        if (env.BRANCH_NAME == 'staging') {
             stage 'deploy to staging'
             echo 'bundle exec cap staging deploy'
        }

        if (env.BRANCH_NAME == 'testing') {
             stage 'deploy to testing'
             echo 'bundle exec cap testing deploy'
        }

        if (env.BRANCH_NAME == 'development') {
             stage 'deploy to development'
             echo 'bundle exec cap development deploy'
        }

    }
}
