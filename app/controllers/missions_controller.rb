class MissionsController < ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy]

  # GET /missions
  # GET /missions.json
  def index
    @planets = current_user.visible_planets.uniq!
    @galaxies = current_user.visible_galaxies.uniq!
    @sunsystems = current_user.visible_sunsystems.uniq!

    @susy_names_hash = Hash.new
    @sunsystems.each do |sunsystem|
      @susy_names_hash[sunsystem.id] = sunsystem.name
    end
    
    @planets_names_hash = Hash.new
    @planets.each do |planet|
      @planets_names_hash[planet.id] = planet.name
    end
      
    @susy_hash = Hash.new
    @planets.each do |planet|
      if @susy_hash.has_key?(planet.sunsystem.id)
        @susy_hash[planet.sunsystem.id].push(planet.id)
      else
        @susy_hash[planet.sunsystem.id] = [planet.id]
      end
    end

    @gala_hash = Hash.new
    @sunsystems.each do |sunsystem|
      if @gala_hash.has_key?(sunsystem.galaxy.id)
        @gala_hash[sunsystem.galaxy.id].push(sunsystem.id)
      else
        @gala_hash[sunsystem.galaxy.id] = [sunsystem.id]
      end
    end

    @fleets = Fleet.where("start_planet=target_planet AND user_id = ?", current_user.id)
    @ships = Ship.get_property_hash
  end

  # GET /missions/1
  # GET /missions/1.json
  def show
  end

  # GET /json/distance
  # FEHLERBEHANDLUNG
  def get_distance()
    planet1 = Planet.find(params[:planet1])
    planet2 = Planet.find(params[:planet2])
    distance = planet1.getDistance(planet2).to_json
    render :json => distance
  end

  # GET /json/fleetships
  # FEHLERBEHANDLUNG
  def get_ships()
    fleet = Fleet.find(params[:fleet_id])
    render :json => fleet.get_ships_ids.to_json
  end

  # GET /missions/new
  def new
    @mission = Mission.new
  end

  # GET /missions/1/edit
  def edit
  end

  # POST /missions
  # POST /missions.json
  def create
    @mission = Mission.new(mission_params)

    respond_to do |format|
      if @mission.save
        format.html { redirect_to @mission, notice: 'Mission was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mission }
      else
        format.html { render action: 'new' }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /missions/1
  # PATCH/PUT /missions/1.json
  def update
    respond_to do |format|
      if @mission.update(mission_params)
        format.html { redirect_to @mission, notice: 'Mission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1
  # DELETE /missions/1.json
  def destroy
    @mission.destroy
    respond_to do |format|
      format.html { redirect_to missions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission
      @mission = Mission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mission_params
      params.require(:mission).permit(:info_text)
    end
end
