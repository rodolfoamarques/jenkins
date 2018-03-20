require 'net/ssh'

# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'jenkins'
set :repo_url, 'https://github.com/tarrynn/jenkins.git'
set :log_level, :debug
set :branch, 'development'
set :bundle_flags, '--deployment --quiet'
set :deploy_to, -> { "/home/#{fetch :user}/Desktop/deployments/#{fetch :application}/#{fetch :stage}" }
set :project_path, -> { "/home/#{fetch :user}/Desktop/deployments/#{fetch :application}" }
set :format, :pretty
set :keep_releases, 2
set :log_level, :debug
set :rails_env, -> { fetch :stage } # For capistrano3-unicorn.
set :rbenv_ruby, '2.2.9'
set :scm, :git
set :ssh_options, keys: ['../../ssh_keys/localhost']
set :user, 'tarrynn'

namespace :deploy do # get dependencies and run migrations before symlink to current folder
  after :deploy, :updated do
    on roles(:app) do
      execute "cd '#{release_path}'; /home/#{fetch :user}/bin/composer install --no-dev", raise_on_non_zero_exit: true
    end
    on roles(:db) do # migrations
      execute "cd '#{release_path}'; echo 'run migrations'", raise_on_non_zero_exit: true
    end
  end
end

namespace :deploy do
  desc 'Restart application'
  task :build do
    on roles(:web) do
      execute "echo 'restart webserver here'"
    end
  end

  after :published, :build
end

namespace :deploy do
  desc 'deploy .htaccess'
  task :copy_htaccess do
    #copy .htaccess at the environment level so that apache can do the switch there
    execute "cd '#{release_path}'; cp -rf ./.htaccess #{fetch :project_path}", raise_on_non_zero_exit: true
  end

  after :finished, :copy_htaccess
end

# this will be the d01 dev server as a proxy to the actual servers we need to deploy to
if ENV['VIA_BASTION']
  bastion_host = 'bastion.host.here'
  bastion_user = 'deploy'

  # Configure Capistrano to use the bastion host as a proxy
  #
  ssh_command = "ssh -a -v #{bastion_user}@#{bastion_host} -W %h:%p -oStrictHostKeyChecking=no"
  set :ssh_options, proxy: Net::SSH::Proxy::Command.new(ssh_command)
end
