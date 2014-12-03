require "rails_helper"

RSpec.describe MessagesController, type: :routing do
  describe "routing" do
    let(:message) { create(:message) }

    it 'routes to #new' do
      expect(get: '/').to route_to('messages#new')
    end

    it 'routes to #show' do
      expect(get: "/m/#{message.token}").to route_to('messages#show', token: message.token)
    end

    it 'routes to #create' do
      expect(post: '/m').to route_to("messages#create")
    end

    it 'routes to #destroy' do
      expect(delete: "/m/#{message.token}").to route_to('messages#destroy', token: message.token)
    end

    it 'does not route by message id' do
      expect(get: "/messages/#{message.id}").not_to be_routable
      expect(delete: "/messages/#{message.id}").not_to be_routable
    end

  end
end
