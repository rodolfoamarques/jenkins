node {
    stage 'checkout repo'
    checkout scm

    stage 'start mysql'
    docker.image('mysql:5.6').withRun('-e "MYSQL_ROOT_PASSWORD=mysql" -p 3306:3306') { c ->

        docker.image('redis:3.0.7-alpine').withRun('-p 6379:6379') { c2 ->

            stage 'build the app'
            docker.image('tarrynn/php5.6_utils:latest').inside("--link ${c.id}:db --link ${c2.id}:redis") {
                sh 'composer install'
                sh 'ping db'
                sh 'ping redis'
            }

        }

        docker.image('mysql:5.6').inside("--link ${c.id}:db") {
            /* Wait until mysql service is up */
            sh 'while ! mysqladmin ping -h db --silent; do sleep 1; done'
        }

        stage 'setup test database'
        docker.image('mysql:5.6').inside("--link ${c.id}:db") {
            sh 'mysqladmin -u root -pmysql -h db create test'
            sh 'mysql -u root -pmysql -h db -e "show databases;"'
        }

        stage 'build the app'
        docker.image('tarrynn/php5.6_utils:latest').inside("--link ${c.id}:db") {
            sh 'composer install'
        }

        stage 'run tests'
        docker.image('tarrynn/php5.6_utils:latest').inside("--link ${c.id}:db") {
            sh './vendor/bin/phpunit --version'
        }
    }

    stage 'prepare deployment'
    docker.image('ruby:2.2.9').withRun('') { c ->
        echo 'installing bundler'
        sh 'gem install bundler'
        sh 'bundle install'
    }

    docker.image('ruby:2.2.9').withRun('') { c ->
        if (env.BRANCH_NAME == 'master') {
             stage 'deploy to production'
             sh 'bundle exec cap production deploy'
        }

        if (env.BRANCH_NAME == 'staging') {
             stage 'deploy to staging'
             sh 'bundle exec cap staging deploy'
        }

        if (env.BRANCH_NAME == 'testing') {
             stage 'deploy to testing'
             sh 'bundle exec cap testing deploy'
        }

        if (env.BRANCH_NAME == 'development') {
             stage 'deploy to development'
             sh 'bundle exec cap development deploy'
        }
    }
}
