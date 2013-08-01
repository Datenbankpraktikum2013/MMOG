class BattlereportsController < ApplicationController
  before_action :set_battlereport, only: [:show, :edit, :update, :destroy]

  # GET /battlereports
  # GET /battlereports.json
  def index
    @battlereports = Battlereport.all
  end

  # GET /battlereports/1
  # GET /battlereports/1.json
  def show
  end

  # GET /battlereports/new
  def new
    @battlereport = Battlereport.new
  end

  # GET /battlereports/1/edit
  def edit
  end

  # POST /battlereports
  # POST /battlereports.json
  def create
    @battlereport = Battlereport.new(battlereport_params)

    respond_to do |format|
      if @battlereport.save
        format.html { redirect_to @battlereport, notice: 'Battlereport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @battlereport }
      else
        format.html { render action: 'new' }
        format.json { render json: @battlereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /battlereports/1
  # PATCH/PUT /battlereports/1.json
  def update
    respond_to do |format|
      if @battlereport.update(battlereport_params)
        format.html { redirect_to @battlereport, notice: 'Battlereport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @battlereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battlereports/1
  # DELETE /battlereports/1.json
  def destroy
    @battlereport.destroy
    respond_to do |format|
      format.html { redirect_to battlereports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battlereport
      @battlereport = Battlereport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def battlereport_params
      params.require(:battlereport).permit(:defender_planet_id, :attacker_planet_id, :fightdate, :stolen_ore, :stolen_crystal, :stolen_space_cash, :defender_id, :attacker_id, :winner_id)
    end
end
