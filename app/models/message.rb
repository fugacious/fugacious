class Message < ActiveRecord::Base
  validates_presence_of :body, :message => "can't be blank"
  attr_accessible :body, :views, :max_views, :hours
  
  before_create :make_token
  
  def add_view
    self.update_attribute :views, (self.views.to_i + 1)
  end
  
  def make_token
    self.token = SecureRandom.base64(23).tr('+/=', 'xyz')
  end
  
   HUMANIZED_ATTRIBUTES = {:body => "Secret message"}
  
  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  def expired?
    expired_by_time? || expired_by_views?
  end
  
  def expired_by_time?
    created_at + hours.hours + 1.second < Time.now ? true : false
  end
  
  def expired_by_views?
    views >= max_views ? true : false 
  end
  
  protected
  
  # expire messages that were not manually deleted by the user
  # this will need to be refactored once the db size scales.
  def self.expire_messages!
    messages = self.all
    messages.map { |m| m.destroy if m.expired_by_views? || m.expired_by_time? }
  end

end
