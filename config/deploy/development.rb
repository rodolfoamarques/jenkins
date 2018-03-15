set :branch, 'development'
set :stage, :development

server '172.17.0.1', user: "#{fetch :user}", roles: %w(web app db)
