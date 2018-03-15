node {
    stage 'checkout repo'
    checkout scm

    stage 'start mysql'
    docker.image('mysql:5.6').withRun('-e "MYSQL_ROOT_PASSWORD=mysql"') { c ->
        docker.image('mysql:5.6').inside("--link ${c.id}:db") {
            /* Wait until mysql service is up */
            sh 'while ! mysqladmin ping -h db --silent; do sleep 1; done'
            sh 'mysqladmin -u root -pmysql -h db create test'
            sh 'mysql -u root -pmysql -h db -e "show databases;"'
        }

        stage 'setup test database'
        docker.image('mysql:5.6').inside("--link ${c.id}:db") {
            sh 'mysqladmin -u root -pmysql -h db create test'
            sh 'mysql -u root -pmysql -h db -e "show databases;"'
        }

        stage 'build the app'
        docker.image('tarrynn/php5.6_utils:local').inside("--link ${c.id}:db") {
            sh 'composer install'
        }

        stage 'run tests'
        docker.image('tarrynn/php5.6_utils:local').inside("--link ${c.id}:db") {
            sh './vendor/bin/phpunit --version'
        }
    }

    stage 'prepare deployment'
    docker.image('ruby:2.2.9').withRun('') { c ->
        echo 'installing bundler'
        sh 'gem install bundler'
        sh 'bundle install'
    }

    stage 'deploy to enviroment'
    docker.image('ruby:2.2.9').withRun('') { c ->
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
             sh 'bundle exec cap development deploy'
        }
    }
}
