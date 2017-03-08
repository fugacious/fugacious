class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  before_action :handle_bot_requests, except: :new
  before_action :set_message, only: [:show, :destroy]

  def show
    if @message
      @message.add_view
      if @message.views == 0
        flash.now[:success] = I18n.t('flash.created')
      else
        flash.now[:warning] = I18n.t('flash.temporary')
      end
    else
      flash.now[:warning] = I18n.t('flash.expired_or')
      render '/messages/gone'
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to message_url(@message.token)}
        format.json { render :show, status: :created, location: @message }
      else
        flash.now[:error] = @message.errors.full_messages.to_sentence
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: I18n.t('flash.destroy_success') }
      format.json { head :no_content }
    end
  end

  private

  def set_message
    @message = Message.find_by_token(params[:token])
  end

  def message_params
    params.require(:message).permit(:body, :max_views, :hours)
  end

  def handle_bot_requests
    disallowed_bots = ['Googlebot', 'Yahoo!', 'bingbot', 'AhrefsBot', 'Baiduspider', 'Ezooms',
                       'MJ12bot', 'YandexBot', 'Slackbot']
    bot_regexp = /#{disallowed_bots.join('|')}/
    render template: 'messages/gone', status: 404, layout: nil if
      bot_regexp === request.user_agent
  end
end
