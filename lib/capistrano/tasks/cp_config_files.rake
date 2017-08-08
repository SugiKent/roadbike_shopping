namespace :cp_config_files do
  task :environment do
    set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
    set :unicorn_config, "#{current_path}/config/unicorn/#{fetch(:rails_env)}.rb"
  end
  def cp_files
    root_dir = '/home/ec2-user/rails_app'
    within current_path do
      execute "cp #{root_dir}/config/database.yml #{root_dir}/shared/config/database.yml;cp #{root_dir}/config/secrets.yml #{root_dir}/shared/config/secrets.yml"
    end
  end

 desc "cp database.yml & secrets.yml"
  task :cp => :environment do
    on roles(:app) do
      cp_files
    end
  end
end
