class RanksController < ApplicationController
  before_action :set_rank, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /ranks/new
  def new
    if current_user.alliance==nil or current_user.alliance.permission?(current_user,"edit_ranks")==false
      respond_to do |format|
        format.html { redirect_to current_user.alliance, notice: GameSettings.get("ERRMSG_RANK_NEW")}
      end
    else
      @rank = Rank.new
    end
  end

  # GET /ranks/1/edit
  def edit
    if current_user.alliance==nil and current_user.alliance.permission?(current_user,"edit_ranks")==false
      respond_to do |format|
        format.html { redirect_to edit_alliance_url(@rank.alliance), notice: GameSettings.get("ERRMSG_RANK_EDIT") }
      end
    else
      if @rank.is_founder 
        respond_to do |format|
          format.html { render action: 'edit_founder'}
        end
      end
    end
  end

  # POST /ranks
  # POST /ranks.json
  def create
    @rank = Rank.new(rank_params)
    respond_to do |format|
      @rank.alliance=current_user.alliance
      if current_user.alliance!=nil and current_user.alliance.permission?(current_user,"edit_ranks") and @rank.save
        format.html { redirect_to edit_alliance_url(@rank.alliance), notice: GameSettings.get("SUCCESSMSG_RANK_CREATED") }
      else
        format.html { redirect_to @rank.alliance, notice: GameSettings.get("ERRMSG_RANK_CREATED") }
      end
    end
  end

  # PATCH/PUT /ranks/1
  # PATCH/PUT /ranks/1.json
  def update
    respond_to do |format|
      p=rank_params
      p={ :name => params['rank']['name']} if @rank.is_founder
      if current_user.alliance==@rank.alliance and current_user.alliance.permission?(current_user,"edit_ranks") and @rank.update(p)
        format.html { redirect_to alliances_path, notice: GameSettings.get("SUCCESSMSG_RANK_UPDATE") }
      else
        format.html { redirect_to alliances_path, notice: GameSettings.get("ERRMSG_RANK_UPDATE") }
      end
    end
  end

  # DELETE /ranks/1
  # DELETE /ranks/1.json
  def destroy
    if current_user.alliance==@rank.alliance and @rank.alliance.permission?(current_user,"edit_ranks")
      respond_to do |format|
        unless @rank.standard or @rank.is_founder
          #find default rank
          @alliance=@rank.alliance
          @default=@alliance.ranks.where(:standard=>true).first
          @rank.users.each do |u|
            @default.users<<u
          end
          @rank.destroy
          format.html { redirect_to alliances_path, notice: GameSettings.get("SUCCESSMSG_RANK_DESTROY") }
        else
          format.html { redirect_to alliances_path, notice: GameSettings.get("ERRMSG_RANK_DESTROY") }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rank
      @rank = Rank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rank_params
      params.require(:rank).permit(:name, :can_kick, :can_massmail, :can_change_description, :can_edit_ranks, :can_invite, :can_disband)
    end
end
