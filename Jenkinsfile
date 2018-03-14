node {
    checkout scm
    docker.image('mysql:5').withRun('-e "MYSQL_ROOT_PASSWORD=my-secret-pw"') { c ->
        docker.image('mysql:5').inside("--link ${c.id}:db") {
            /* Wait until mysql service is up */
            sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'
        }
        docker.image('php:5.6-cli-jessie').inside("--link ${c.id}:db") {
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
}
