class Message < ActiveRecord::Base
  validates_presence_of :body, :message => "can't be blank"
  attr_accessible :body, :views, :max_views, :hours
  
  before_create :make_token
  
  def add_view
    self.update_attribute :views, (self.views.to_i + 1)
  end
  
  def make_token
    self.token = ActiveSupport::SecureRandom.base64(23).tr('+/=', 'xyz')
  end
  
   HUMANIZED_ATTRIBUTES = {:body => "Secret message"}
  
  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
    
end
