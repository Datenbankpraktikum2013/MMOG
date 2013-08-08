class RanksController < ApplicationController
  before_action :set_rank, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /ranks/new
  def new
    @rank = Rank.new
  end

  # GET /ranks/1/edit
  def edit
  end

  # POST /ranks
  # POST /ranks.json
  def create
    if current_user.alliance!=nil and current_user.rank.can_edit_ranks
      @rank = Rank.new(rank_params)
      respond_to do |format|
        @rank.alliance=current_user.alliance
        if @rank.save
          format.html { redirect_to edit_alliance_url(@rank.alliance), notice: 'Rang wurde erstellt.' }
          format.json { render action: 'show', status: :created, location: @rank }
        else
          format.html { render action: 'new' }
          format.json { render json: @rank.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /ranks/1
  # PATCH/PUT /ranks/1.json
  def update
    if current_user.alliance==@rank.alliance and current_user.rank.can_edit_ranks and @rank.is_founder == false
      respond_to do |format|
        if @rank.update(rank_params)
          format.html { redirect_to @rank, notice: 'Rang wurde erfolgreich bearbeitet.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @rank.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /ranks/1
  # DELETE /ranks/1.json
  def destroy
    if current_user.alliance==@alliance and current_user.rank.can_edit_ranks
      unless @rank.standard or @rank.is_founder
        #find default rank
        @alliance=@rank.alliance
        @default=@alliance.ranks.where(:standard=>true).first
        @rank.users.each do |u|
          @default.users<<u
        end
        @rank.destroy
      end
    end
    respond_to do |format|
      format.html { redirect_to @alliance }
      format.json { head :no_content }
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
