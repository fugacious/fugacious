require 'rails_helper'
require 'timecop'
require 'rake'
require 'pry'

Rails.application.load_tasks

describe 'Message Expiration Worker' do
  before do
    Message.destroy_all
    Message.create(body: 'I am a message', hours: 1)
    Message.create(body: 'I am a message', hours: 2)
    Message.create(body: 'I am a message', hours: 3)
    Message.create(body: 'I am a message', hours: 4)
  end

  it 'erases expired messages' do
    Timecop.freeze(Time.now + 1.hour + 10.minutes)
    MessageExpiryWorker.new.perform
    expect(Message.count).to eq(3)
  end

  it 'does not erase messages that are not expired' do
    Timecop.freeze(Time.now + 2.hours + 10.minutes)
    MessageExpiryWorker.new.perform
    Message.all.each do |m|
      expect(m.expired?).to eq(false)
    end
    expect(Message.count).to eq(2)
  end
end
