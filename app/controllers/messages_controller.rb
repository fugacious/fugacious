class MessagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :new, :create, :destroy]


  def index
    @messages = Message.all
  end

  def show
    @message = Message.find_by_token(params[:id])
    
    if @message
      @message.add_view unless current_user
    
      @remaining_views = @message.max_views - @message.views
      @time_elapsed = ((Time.now - @message.created_at)/3600)
      @time_left = (@message.hours - @time_elapsed)
      @link = 'https://' + APP_CONFIG[:domain] + message_path(@message.token)
      
      @message.destroy if (@remaining_views == 0 || @time_left < 0)
      redirect_to new_message_path, :notice => "Sorry, that message has expired. Care to create a new one?" if @time_left < 0
    else
      redirect_to new_message_path, :notice => "Sorry, that message has expired. Care to create a new one?" 
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.save
      redirect_to message_path(@message.token), :notice => "Successfully created message."
    else
      render :action => 'new'
    end
  end

  def edit
    @message = Message.find_by_token(params[:id])
  end

  def update
    @message = Message.find_by_token(params[:id])
    if @message.update_attributes(params[:message])
      redirect_to @message.token, :notice  => "Successfully updated message."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @message = Message.find_by_token(params[:id])
    @message.destroy
    redirect_to new_message_path, :notice => "Successfully destroyed message."
  end
end
