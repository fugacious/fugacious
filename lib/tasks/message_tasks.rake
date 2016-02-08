require 'message'
require_relative '../../app/workers/message_expiry_worker'
 
namespace :import_tweets do
 
  task :check_expiry => :environment do
 
    Message.all.each do |message|
      MessageExpiryWorker.perform_async(message.id)
    end
  end
end