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
      if @usr!=nil and @request.save
        @request.decide_notify()
        format.html { redirect_to root_path, notice: GameSettings.get("SUCCESSMSG_REQUESTCREATE") }
      else
        format.html { redirect_to root_path, notice: GameSettings.get("ERRMSG_REQUESTCREATE") }
      end
    end
  end

  def reaction
    answer=params['answer']
    token=params['for']
    request=Request.all.where(:requestvalue=>token).first
    respond_to do |format|
      if request!=nil and request.recipient==current_user
        if answer=='no'
          request.destroy
          format.html { redirect_to root_path, notice: GameSettings.get("DECLINEMSG_REQUESTREACTION") }
        elsif answer=='yes'
          request.launch_action!
          format.html { redirect_to root_path, notice: GameSettings.get("ACCEPTMSG_REQUESTREACTION") }
        end
      else
        format.html { redirect_to root_path, notice: GameSettings.get("ERRMSG_REQUESTREACTION") }
      end
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
