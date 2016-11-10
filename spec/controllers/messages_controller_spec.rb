require 'rails_helper'

RSpec.describe MessagesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Message. As you add validations to Message, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    # skip("Add a hash of attributes valid for your model")
    { "body"=>"message body", "max_views"=>(1..10).to_a.sample.to_s, "hours"=>(1..100).to_a.sample.to_s}
  }

  let(:invalid_attributes) {
    { "message"=> { "body"=>"message body", "max_views"=>"", "hours"=>(1..100).to_a.sample.to_s}}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MessagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET show" do
    before do
      @message = message = Message.create! valid_attributes
    end

    it "assigns the requested message as @message" do
      get :show, {:token => @message.to_param}, valid_session
      expect(assigns(:message)).to eq(@message)
    end

    it "does not permit bots" do
      bots = ['Googlebot', 'Yahoo!', 'bingbot', 'AhrefsBot', 'Baiduspider', 'Ezooms',
        'MJ12bot', 'YandexBot', 'Slackbot']
      # Slack's entire user agent string below:
      # request.env['HTTP_USER_AGENT'] = 'Slackbot-LinkExpanding 1.0 ' \
      #                                  '(+https://api.slack.com/robots)'
      request.env['HTTP_USER_AGENT'] = bots.sample
      get :show, {:token => @message.to_param}, valid_session
      expect(@message.views).to eq(-1)
      expect(response.code.to_i).to eq(404)
    end
  end

  describe "GET new" do
    it "assigns a new message as @message" do
      get :new, {}, valid_session
      expect(assigns(:message)).to be_a_new(Message)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Message" do
        expect {
          post :create, {:message => valid_attributes}, valid_session
        }.to change(Message, :count).by(1)
      end

      it "assigns a newly created message as @message" do
        post :create, {:message => valid_attributes}, valid_session
        expect(assigns(:message)).to be_a(Message)
        expect(assigns(:message)).to be_persisted
      end

      it "redirects to the created message" do
        post :create, {:message => valid_attributes}, valid_session
        expect(response).to redirect_to(Message.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved message as @message" do
        post :create, {:message => invalid_attributes}, valid_session
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "re-renders the 'new' template" do
        post :create, {:message => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end

    describe 'without a valid session' do
      before do
        ActionController::Base.allow_forgery_protection = true
      end

      after do
        ActionController::Base.allow_forgery_protection = false
      end

      it 'accepts an application/json content request' do
        request.headers['HTTP_CONTENT_TYPE'] = 'application/json'
        request.headers['HTTP_ACCEPT'] = 'application/json'

        post :create, { message: valid_attributes }

        message_url = Rails.application.routes.url_helpers.message_url(
          token: Message.last.token,
          host: @request.host)
        expect(response.code.to_i).to eq(201)
        expect(response.headers['Location']).to eq(message_url)
      end

      it 'rejects a text/html content request' do
        request.headers['HTTP_CONTENT_TYPE'] = 'text/html'
        request.headers['HTTP_ACCEPT'] = 'text/html'

        post :create, { message: valid_attributes }

        Rails.application.routes.url_helpers.message_url(
          token: Message.last.token,
          host: @request.host)
        expect(response.code.to_i).to eq(422)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested message" do
      message = Message.create! valid_attributes
      expect {
        delete :destroy, {:token => message.to_param}, valid_session
      }.to change(Message, :count).by(-1)
    end

    it "redirects to the messages list" do
      message = Message.create! valid_attributes
      delete :destroy, {:token => message.to_param}, valid_session
      expect(response).to redirect_to(root_url)
    end
  end
end
