set :branch, 'testing'
set :stage, :testing

server '172.17.0.1', user: "#{fetch :user}", roles: %w(web app db)
