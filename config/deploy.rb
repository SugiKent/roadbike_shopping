# config valid only for current version of Capistrano
lock "3.9.0"

set :application, "roadbike_shopping"
set :repo_url, "git@github.com:SugiKent/roadbike_shopping.git"

set :branch, 'master'
set :deploy_to, '/var/www/roadbike_shopping'
set :scm, :git
set :log_level, :debug
set :pty, true
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets}
set :default_env, { path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end

after "deploy", "deploy:cleanup"
