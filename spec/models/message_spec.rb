require 'rails_helper'

RSpec.describe Message, type: 'model' do

	it 'is valid with a message body' do
		expect(Message.new(body: 'may the force be with you')).to be_valid
	end

	it 'is invalid without a message body' do
		expect(Message.new).to_not be_valid
		expect(Message.new).to have(1).errors_on(:body)
	end

	it 'humanizes the body attribute with "Message"' do
		expect(Message.human_attribute_name(:body)).to eq('Message')
	end

	describe '@instance_methods' do
		let(:message) { FactoryGirl.create(:message) }

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
end
