require "bundler/capistrano"
default_run_options[:pty] = true
set :rvm_ruby_string, '1.9.3@fugacio.us'        # Or whatever env you want it to run in.
set :application, "fugacio.us"
set :deploy_to, "/var/rails/#{application}" # I like this location
set :domain, 'test.fugacio.us'
set :keep_releases, 2
set :repository,  "https://github.com/jgrevich/fugacious.git"
set :scm, :git
set :user, 'ubuntu'

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "chown & chmod to www-data"
  task :chown do
    sudo "chown -R www-data:www-data #{deploy_to}"
    sudo "chmod -R 775 #{deploy_to}"
  end
end

after :deploy, 'deploy:chown'

