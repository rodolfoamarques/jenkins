set :branch, 'staging'
set :stage, :staging

server '172.17.0.1', user: "#{fetch :user}", roles: %w(web app db)
