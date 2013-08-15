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
    @planet = Planet.find(params[:id])
    if @planet.user.nil? then
      respond_to do |format|
        format.html { redirect_to galaxies_url }
        format.json { head :no_content }
      end
    else
      if @planet.user == current_user then

      else
        if (x = @planet.user.alliance).nil? then
          respond_to do |format|
            format.html { redirect_to galaxies_url }
            format.json { head :no_content }
          end
        else
          if x.users.include?(current_user) then

          else
            respond_to do |format|
              format.html { redirect_to galaxies_url }
              format.json { head :no_content }
            end
          end
          end
      end
    end
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
    if @planet.user.id == current_user.id then
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
  end

  def rename_planet
    @planet = Planet.find(params["planets"]["id"])
    if !@planet.user.nil? && @planet.user.id == current_user.id && params["planets"]["planet_name"].length > 3 then
      @planet.name = params["planets"]["planet_name"]
      @planet.save
    end
    respond_to do |format|
      format.html { redirect_to @planet, notice: 'Planet umbenannt.' }
      format.json { render action: 'show' }
    end
  end


  def abort_upgrade
    @planet = Planet.find(params["pid"])
    if @planet.delete_building_job(params["bid"].to_i) then
    
      respond_to do |format|
        format.html { redirect_to @planet, notice: 'Bau abgebrochen.'}
        format.json { render action: 'show' }
      end
    else
      @planet.under_construction = 0
      @planet.save
      respond_to do |format|
        format.html { redirect_to @planet, notice: 'Bau konnte nicht abgebrochen werden, hardreset?!.'}
        format.json { render action: 'show' }
      end
    end
  end
  def set_home_planet
    @planet = Planet.find(params["id"])
    u=@planet.user
    if(!u.nil? && current_user.id == @planet.user.id)
    @planet.set_home_planet(current_user)

          respond_to do |format|
        format.html { redirect_to @planet, notice: 'Homeplanet set.'}
        format.json { render action: 'show' }
      end
    else
                respond_to do |format|
        format.html { redirect_to @planet, notice: 'Not yours to own!'}
        format.json { render action: 'show' }
      end
  end
  end 

  def redirect_to_planet
    if !params["planet_name"].nil?
      @planet = Planet.find(params["planet_name"])
    end
    if !params["allied_planet_name"].nil?
      @planet = Planet.find(params["allied_planet_name"])
    end
      respond_to do |format|
        format.html { redirect_to @planet, notice: 'Schnellreise erfolgreich.'}
        format.json { render action: 'show' }
      end

  end

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
