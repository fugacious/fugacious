# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
Dir.glob('tasks/*.rake').each { |r| import r }

Rails.application.load_tasks
