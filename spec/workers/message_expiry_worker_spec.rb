require 'rails_helper'
require 'timecop'
require 'rake'
require 'pry'

Rails.application.load_tasks

describe 'Message Expiration Worker' do

  before do
    # Redis.connect(ENV['REDIS_URL']) 
    # redis.flushdb

    Message.create(body: 'I am a message')
    Message.create(body: 'I am a message', hours: 1)
    Message.create(body: 'I am a message', hours: 2)
    Message.create(body: 'I am a message', hours: 3)
  end

  it 'erases expired messages' do
    Timecop.freeze(Time.now + 1.hour + 10.minutes)
    Rake::Task['message_task:check_expiry'].execute
    expect(Message.all.length).to eq(3)
  end

  it 'does not erase messages that are not expired' do
    Timecop.freeze(Time.now + 1.hour + 10.minutes)
    Rake::Task['message_task:check_expiry'].execute
    Message.all.each do |m|
      expect(m.expired?).to eq(false)
    end
  end
end