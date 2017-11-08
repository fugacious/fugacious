require 'rails_helper'

RSpec.describe MessagesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Message. As you add validations to Message, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { body: "message body",
      max_views: (1..10).to_a.sample.to_s,
      hours: (1..100).to_a.sample.to_s}
  }

  let(:invalid_attributes) {
    { message: {
      body: "message body",
      max_views: ['-1', '', 'seven'].sample,
      hours: (1..100).to_a.sample.to_s}
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MessagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET show" do
    render_views

    it "assigns the requested message as @message" do
      message = create(:message)
      get :show, { token: message.to_param}, valid_session
      expect(assigns(:message)).to eq(message)
    end

    it "does not permit bots" do
      message = create(:message)
      bots = ['Googlebot', 'Yahoo!', 'bingbot', 'AhrefsBot', 'Baiduspider', 'Ezooms',
        'MJ12bot', 'YandexBot', 'Slackbot']
      # Slack's entire user agent string below:
      # request.env['HTTP_USER_AGENT'] = 'Slackbot-LinkExpanding 1.0 ' \
      #                                  '(+https://api.slack.com/robots)'
      request.env['HTTP_USER_AGENT'] = bots.sample
      get :show, { token: message.to_param }, valid_session
      expect(message.views).to eq(0)
      expect(response.code.to_i).to eq(404)
    end

    it "does not expose expired messages" do
      message = create(:message, { hours: 1, body: '!this message is expired!' })
      get :show, { token: message.to_param}, valid_session
      expect(response.status).to eq(200)

      Timecop.freeze(Time.now + 2.hours)
      expect(message.expired?).to eq(true)

      get :show, { token: message.to_param}, valid_session
      expect(response.body).to_not have_content('!this message is expired!')
      expect(response.body).to have_content(I18n.t('flash.expired_or'))
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
          post :create, { message: valid_attributes }, valid_session
        }.to change(Message, :count).by(1)
      end

      it "assigns a newly created message as @message" do
        post :create, { message: valid_attributes }, valid_session
        expect(assigns(:message)).to be_a(Message)
        expect(assigns(:message)).to be_persisted
      end

      it "redirects to the created message" do
        post :create, { message: valid_attributes }, valid_session
        expect(response).to redirect_to(Message.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved message as @message" do
        post :create, { message: invalid_attributes}, valid_session
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "re-renders the 'new' template" do
        post :create, { message: invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end

    describe 'without a valid session' do
      before do
        ActionController::Base.allow_forgery_protection = true
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

         expect(response.code.to_i).to eq(422)
         expect(response).to render_template('shared/422')
       end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested message" do
      message = create(:message)
      expect {
        delete :destroy, { token: message.to_param }, valid_session
      }.to change(Message, :count).by(-1)
    end

    it "redirects to the messages list" do
      message = create(:message)
      delete :destroy, { token: message.to_param }, valid_session
      expect(response).to redirect_to(root_url)
    end
  end
end
