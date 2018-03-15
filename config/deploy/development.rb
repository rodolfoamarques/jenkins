set :branch, 'development'
set :stage, :development

server 'localhost', user: "#{fetch :user}", roles: %w(web app db)
