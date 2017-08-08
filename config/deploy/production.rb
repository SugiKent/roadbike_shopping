set :rails_env, "production"
set :unicorn_rack_env, "production"

role :app, %w{root@203.104.205.170}
role :web, %w{root@203.104.205.170}
role :db,  %w{root@203.104.205.170}

server '203.104.205.170', user: 'root', roles: %w{web app}

set :ssh_options, {
  keys: %w(/vagrant/roadbike_shopping.pem),
  forward_agent: false,
  auth_methods: %w(publickey)
}
