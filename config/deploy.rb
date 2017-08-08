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
  task :default do
    update
  end

  task :update do
    transaction do
      update_code
      create_config_symlink
      create_symlink
    end
  end

  task :start do
    run "cd #{current_path} && bundle exec unicorn_rails -c #{current_path}/config/unicorn.rb -E #{rails_env} -D"
  end

  task :restart do
    stop
    start
  end

  task :reload do
    if File.exist? "#{current_path}/tmp/pids/unicorn.pid"
      run "kill -s USR2 `cat #{current_path}/tmp/pids/unicorn.pid`"
    else
      start
    end
  end

  task :stop do
    run "kill -s QUIT `cat #{current_path}/tmp/pids/unicorn.pid`"
  end

  task :cache_clear do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake tmp:cache:clear"
  end

  task :precompile, :roles => :web do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end

  task :create_config_symlink, :roles => :web do
    on_rollback { run "rm -rf #{release_path}; true" }
    run "cp #{release_path}/config/database.yml.base #{shared_path}/database.yml && ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "cp #{release_path}/config/unicorn/#{rails_env}.rb #{shared_path}/unicorn.rb && ln -s #{shared_path}/unicorn.rb #{release_path}/config/unicorn.rb"
  end
  # desc 'Restart application'
  # task :restart do
  #   invoke 'unicorn:restart'
  # end
end

after "deploy", "deploy:cleanup"
