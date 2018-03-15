require 'net/ssh'

# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'jenkins'
set :repo_url, 'https://github.com/tarrynn/jenkins.git'
set :log_level, :debug
set :branch, 'development'
set :bundle_flags, '--deployment --quiet'
set :deploy_to, -> { "/home/#{fetch :user}/Desktop/deployments/#{fetch :application}/#{fetch :stage}" }
set :format, :pretty
set :keep_releases, 2
set :log_level, :debug
set :rails_env, -> { fetch :stage } # For capistrano3-unicorn.
set :rbenv_ruby, '2.2.9'
set :scm, :git
set :ssh_options, keys: ['../../ssh_keys/localhost']
set :user, 'tarrynn'

# this will be the d01 dev server as a proxy to the actual servers we need to deploy to
if ENV['VIA_BASTION']
  bastion_host = 'bastion.host.here'
  bastion_user = 'deploy'

  # Configure Capistrano to use the bastion host as a proxy
  #
  ssh_command = "ssh -a -v #{bastion_user}@#{bastion_host} -W %h:%p -oStrictHostKeyChecking=no"
  set :ssh_options, proxy: Net::SSH::Proxy::Command.new(ssh_command)
end
