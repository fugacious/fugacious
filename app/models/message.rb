class Message < ActiveRecord::Base
  before_create :make_token
  validates :body, presence: true
  validates :max_views, presence: true, numericality: { greater_than: 0, message: "Views must be greater than 0"}
  validates :hours, presence: true, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: Rails.application.secrets.max_retention_hours
  }

  HUMANIZED_ATTRIBUTES = { body: 'Message' }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def self.find_active_by_token(token)
    message = Message.find_by(token: token)
    message unless message && message.expired?
  end

  def add_view
    self.update_attribute :views, (self.views.to_i + 1)
    self.destroy if self.expired?
  end

  def expired?
    expired_by_time? || expired_by_views?
  end

  def remaining_views
    self.max_views - self.views
  end

  def time_left
    self.hours - time_elapsed
  end

  def to_param
    token
  end

  private

  def expired_by_time?
    created_at + hours.hours + 1.second < Time.now ? true : false
  end

  def expired_by_views?
    views >= max_views ? true : false
  end

  def make_token
    self.token = SecureRandom.base64(32).tr('+/=', '')[0..32]
  end

  def time_elapsed
    (Time.now - self.created_at)/3600
  end

end
