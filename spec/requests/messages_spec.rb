require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  describe "POST /m" do
    it 'creates a new message based on the posted data' do
      post '/m', message: { body: 'This is only a test', views: 4, hours: 20.0 }

      expect(response).to redirect_to(message_url(assigns(:message).token))
      expect(follow_redirect!).to eq(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(assigns(:message).body)
    end
  end
end
