class MessageExpiryWorker
  include Sidekiq::Worker
  
  def perform(message_id)
    message = Message.find(message_id)
    message.destroy if message.expired?
  end
end