# Load RVM's capistrano plugin.    
require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_ruby_string, '1.9.3'
set :rvm_type, :system  # Use system-wide RVM

default_run_options[:pty] = true
set :rvm_ruby_string, '1.9.3'        # Or whatever env you want it to run in.
set :application, "fugacio.us"
set :deploy_to, "/var/rails/#{application}" # I like this location
set :domain, 'fugacio.us'
set :keep_releases, 2
set :repository,  "https://github.com/jgrevich/fugacious.git"
set :scm, :git
set :user, 'ubuntu'
set :use_sudo, false

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                         # This may be the same as your `Web` server
role :db,  domain, :primary => true        # This is where Rails migrations will run

after 'bundle:install', 'deploy:symlink_db'
after 'deploy:setup', 'deploy:chown'
after 'deploy:setup', 'deploy:add_shared_config'
after :deploy, 'deploy:chown'

namespace :deploy do

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Add config dir to shared folder"
  task :add_shared_config do
    run "mkdir #{deploy_to}/shared/config"
  end

  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/"
  end

  desc "chown & chmod to www-data"
  task :chown do
    sudo "chown -R ubuntu:www-data #{deploy_to}"
    sudo "chmod -R 775 #{deploy_to}"
  end
  
end