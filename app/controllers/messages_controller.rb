class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    if current_user!=@message.sender and @message.recipients.exists?(current_user)
      tag_msg_as_seen(@message)
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
    @recipient = params['recipient']
  end

  def fetch_unread_msgs
    object = {:response => current_user.unread_messages}
    respond_to do |format|
      format.json { render json: object }
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @users=User.all
    @recipient=@users.where('username == ?',params['recipient']).first
    respond_to do |format|
      #assign params
      @message.subject=params['subject']
      @message.body=params['body']
      @message.sender=current_user
      if @recipient!=nil and current_user!=@recipient and @message.save 
        @message.recipients<<@recipient      
        format.html { redirect_to @message, notice: 'Nachricht erfolgreich gesendet' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    if @message.recipients.exists?(current_user)
      @entry=MessagesUser.all.where(:user_id=>current_user,:message_id=>@message).first
      @entry.recipient_deleted=true
      @entry.save
      tag_msg_as_seen(@message)
    elsif current_user==@message.sender
      @message.sender_deleted=true
      @message.save
    end
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:text, :sender_id, :subject) if params[:message]
    end

  private
    def tag_msg_as_seen(msg)
      if(@message.sender!=current_user)
        @entry=MessagesUser.all.where(:user_id=>current_user,:message_id=>@message).first
        @entry.read=true
        @entry.save
      end
    end
end
