class MessageExpiryWorker
  include Sidekiq::Worker
  
  def perform_async(message_id)
    message = Message.find(message_id)
    if message.expired?
      puts "destroying message \##{message_id}"
      message.destroy
    end
  end
end