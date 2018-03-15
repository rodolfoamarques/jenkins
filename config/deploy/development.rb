set :branch, 'development'
set :stage, :development

server '127.0.0.1', user: "#{fetch :user}", roles: %w(web app db)
