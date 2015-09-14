class MessagesController < ApplicationController
  before_action :handle_bot_requests, except: :new
  before_action :set_message, only: [:show, :destroy]

  # GET /messages/1
  # GET /messages/1.json
  def show
    if @message
      @message.add_view
      notice
      flash[:notice] = 'This message has beed deleted from our records.  You must copy the message elsewhere if you wish to keep it any longer.' if @message.remaining_views == 0
      redirect_to @message, notice: 'Sorry, that message has expired. Care to create a new one?' if @message.time_left < 0
    else
      redirect_to root_url, notice: 'Sorry, that message has expired or never existed at all. Care to create a new one?'
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to message_url(@message) }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find_by_token(params[:token])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
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
