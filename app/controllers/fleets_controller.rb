class FleetsController < ApplicationController
  before_action :set_fleet, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  
  # GET /fleets
  # GET /fleets.json
  def index
    @fleets = Fleet.where(user: current_user)
    
    @approaching_fleets = Array.new
    planets = current_user.planets
    planets.each do |planet|
      Fleet.where("target_planet = ? AND start_planet != target_planet", planet).each do |fleet|
        @approaching_fleets.push(fleet)
      end
    end

    @flying_fleets = Array.new
    @based_fleets = Array.new
    @fleets.each do |fleet|
      if fleet.mission.id == 1
        @based_fleets.push(fleet)
      else
        @flying_fleets.push(fleet)
      end
    end
  end

  # GET /fleets/1
  # GET /fleets/1.json
  def show
    puts @fleet.id
    @ship_hash = @fleet.get_ships
  end

  # GET /fleets/new
  def new
    #@fleet = Fleet.new
  end

  # GET /fleets/1/edit
  def edit
  end

  # POST /fleets
  # POST /fleets.json
  def create
    @fleet = Fleet.new(fleet_params)

    respond_to do |format|
      if @fleet.save
        format.html { redirect_to @fleet, notice: 'Fleet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fleet }
      else
        format.html { render action: 'new' }
        format.json { render json: @fleet.errors, status: :unprocessable_entity }
      end
    end
  end

  def breakup
    fleet = Fleet.find(params["fleet"])
    fleet.breakup_mission
    render :json => {"ok" => 1}.to_json
  end

  def unload
    fleet = Fleet.find(params["fleet"])
    planet = Planet.find(params["planet"])
    if fleet.target_planet == fleet.start_planet && planet == fleet.origin_planet
      fleet.unload_ressources(planet)
      status = {"ok" => 1}
    else      
      status = {"ok" => 0}
    end

    render :json => status.to_json
  end

  # PATCH/PUT /fleets/1
  # PATCH/PUT /fleets/1.json
  def update
    respond_to do |format|
      if @fleet.update(fleet_params)
        format.html { redirect_to @fleet, notice: 'Fleet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fleet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fleets/1
  # DELETE /fleets/1.json
  def destroy
    @fleet.destroy
    respond_to do |format|
      format.html { redirect_to fleets_url }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fleet
      @fleet = Fleet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fleet_params
      params.require(:fleet).permit(:credit, :ressource_capacity, :ore, :crystal, :storage_factor, :velocity_factor, :offense, :defense, :user_id, :mission_id, :departure_time, :arrival_time, :start_planet, :target_planet)
    end
end
