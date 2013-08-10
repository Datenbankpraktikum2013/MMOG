class RequestsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_request, only: [:destroy]

  # POST /requests
  # POST /requests.json
  def create
    @usr=User.all.where(:username=>params['recipient']).first
    @request = Request.new(:action=>params['useraction'])
    @request.recipient=@usr
    @request.sender=current_user
    respond_to do |format|
      if @request.save
        @request.decide_notify()
        format.html { redirect_to messages_path, notice: 'Request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @request }
      else

      end
    end
  end

  def reaction
    answer=params['answer']
    token=params['for']
    request=Request.all.where(:requestvalue=>token).first
    if answer=='no'
      request.destroy
    elsif answer=='yes'
      request.sender.alliance.add_user(current_user)
      request.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:action)
    end
end
