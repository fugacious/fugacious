class MessageExpiryWorker
  include Sidekiq::Worker

  def perform()
    Message.all.each do |message|
      if message.expired?
        puts "destroying message \##{message.id}"
        message.destroy
      end
    end
  end
end
