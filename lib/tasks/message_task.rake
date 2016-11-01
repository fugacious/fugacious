require_relative '../../app/models/message.rb'
require_relative '../../app/workers/message_expiry_worker'

namespace :message_task do
  task :check_expiry => :environment do
    puts "Clearing expired messages..."
    Message.all.each do |message|
      MessageExpiryWorker.new.perform_async(message.id)
    end
    puts "done!"
  end
end
