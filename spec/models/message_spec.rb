require 'rails_helper'

RSpec.describe Message do
  describe 'Validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:max_views) }
    it { should validate_presence_of(:hours) }

    it 'is valid with 1 or more max views' do
      expect(Message.new(body: 'may the force be with you', max_views: 1)).to be_valid
    end

    it 'is invalid with less than 1 max view' do
      expect(Message.new(body: 'may the force be with you', max_views: 0)).to_not be_valid
      expect(Message.new(body: 'may the force be with you', max_views: 0)).to have(1).errors_on(:max_views)
    end

    it 'humanizes the body attribute with "Message"' do
      expect(Message.human_attribute_name(:body)).to eq('Message')
    end

    it 'is invalid with less than 1 hour time limit' do
      expect(Message.new(body: 'merp', max_views: 1, hours: 0)).to_not be_valid
      expect(Message.new(body: 'merp', max_views: 1, hours: 0)).to have(1).errors_on(:hours)
    end
  end

  describe '@instance_methods' do
    let(:message) { FactoryBot.create(:message) }

    it 'adds to the view count when the #add_view method is called' do
      views = message.views
      message.add_view

      expect(message.views).to eq(views+1)
    end

    it 'deletes the message if it has expired from the #add_view method' do
      message.views = message.max_views-1
      message.add_view

      expect(Message.exists?(message.id)).to be false
    end
  end

  describe 'a global retention limit' do
    let(:message) { Message.new(body: 'turtles', max_views: 2) }

    context 'with a valid global limit' do
      it 'can not exceed the specified limit' do
        message.hours = Rails.application.secrets.max_retention_hours + 1

        expect(message.save).to be_falsey
        expect(message.errors.include?(:hours)).to be_truthy
      end

      it 'can be within the limit' do
        message.hours = Rails.application.secrets.max_retention_hours / 2

        expect { message.save }.to_not raise_error
      end
    end

    context 'with a limit exceeding 30 days' do
      let(:message) { Message.new(body: 'turtles', max_views: 2) }

      it 'raises exception upon initialization' do
        allow(Rails.application.secrets).to receive(:max_retention_hours).
          and_return(721)

        expect {
            load File.join(Rails.root, 'config', 'initializers', 'max_retention_hours.rb')
          }.to raise_error(RuntimeError, 'Rails.application.secrets.max_retention_hours exceeds 720 hours (30 days)')
      end
    end
  end
end
