class PlanetsController < ApplicationController
  before_action :set_planet, only: [:show, :edit, :update, :destroy]

  # GET /planets
  # GET /planets.json
  def index
    @planets = Planet.all
  end

  # GET /planets/1
  # GET /planets/1.json
  def show

  end

  # GET /planets/new
  def new
    @planet = Planet.new
  end

  # GET /planets/1/edit
  def edit
  end

  # POST /planets
  # POST /planets.json
  def create
    @planet = Planet.new(planet_params)

    respond_to do |format|
      if @planet.save
        format.html { redirect_to @planet, notice: 'Planet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @planet }
      else
        format.html { render action: 'new' }
        format.json { render json: @planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planets/1
  # PATCH/PUT /planets/1.json
  def update
    respond_to do |format|
      if @planet.update(planet_params)
        format.html { redirect_to @planet, notice: 'Planet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @planet.errors, status: :unprocessable_entity }
      end
    end
  end

  def upgrade_building
    @planet = Planet.find(params["id"])
    if @planet.create_building_job(params["btype"].to_sym) then
    
    respond_to do |format|
      format.html { redirect_to @planet, notice: 'Gebäude wird gebaut.' }
      format.json {render action: 'show'}
    end
    else
      respond_to do |format|
      format.html { redirect_to @planet, notice: 'Gebäude kann nicht gebaut werden.'}
      format.json {render action: 'show'}
    end
    end
  end


#  def abort_upgrade
#    Planets.find(params["id"]).delete_building_job(params["uid"])
#    respond_to do |format|
#      format.html { redirect_to action: 'index', notice: 'Bau abgebrochen.'}
#      format.json {head :no_content}
#    end
#  end

  def page_refresh()

    object = {:buildingtype_id => Planet.find(params["id"]).under_construction}
    respond_to do |format|
      format.json { render json: object }
    end
  end

  # DELETE /planets/1
  # DELETE /planets/1.json
  def destroy
    @planet.destroy
    respond_to do |format|
      format.html { redirect_to planets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planet
      @planet = Planet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planet_params
      params.require(:planet).permit(:z, :name, :spezialisierung, :groesse, :eisenerz, :maxeisenerz, :kristalle, :maxkristalle, :energie, :maxenergie, :einwohner, :maxeinwohner)
    end
end
