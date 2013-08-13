class MissionsController < ApplicationController
  # before_action :set_mission, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /missions
  # GET /missions.json
  def index
    @planets = current_user.visible_planets.uniq!
    @galaxies = current_user.visible_galaxies.uniq!
    @sunsystems = current_user.visible_sunsystems.uniq!

    @susy_names_hash = Hash.new
    @sunsystems.each do |sunsystem|
      @susy_names_hash[sunsystem.id] = sunsystem.y.to_s + " &sdot; " + sunsystem.name
    end
    
    @planets_names_hash = Hash.new
    @planets.each do |planet|
      @planets_names_hash[planet.id] = planet.z.to_s + " &sdot; " + planet.name
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
    @mission = Mission.new
  end

  # GET /json/distance
  # NÖTIG????????????????????????
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

  # ESCAPEN????????????????????????????????????
  def check_mission()
    fehler = Array.new
    
    fehler = check_helper(params)

    if fehler.empty?
      render :json => {"ok" => 1}.to_json
    else
      render :json => {"ok" => 0, "error" => fehler}.to_json
    end
  end

  def check_helper(params)
    fehler = Array.new

    begin
      fleet = Fleet.find(params[:fleet])
    rescue
      fehler.push("Fehlerhafte Eingabe der Flotte")
    end

    begin
      mission = Mission.find(params[:mission])
    rescue
      fehler.push("Fehlerhafte Eingabe der Mission")
    end
      
    planet1 = fleet.start_planet
    
    begin
      planet2 = Planet.find(params[:planet])
    rescue
      fehler.push("Fehlerhafte Eingabe des Zielplaneten")
    end

    ress_ore = params.has_key?("ress-ore") ? params["ress-ore"].to_i : 0
    ress_crystal = params.has_key?("ress-crystal") ? params["ress-crystal"].to_i : 0
    ress_credit = params.has_key?("ress-credit") ? params["ress-credit"].to_i : 0

    ship_hash = Hash.new
    # make a {shiptype => amount} hash and put only those inside that were given
    Ship.all.each do |ship|
      if params["ship-#{ship.id}"]
        ship_hash[Ship.find(ship.id)] = params["ship-#{ship.id}"].to_i
      end
    end

    ships = ship_hash.keys
    if ships.empty?
      fehler.push("Bitte Schiffe auswählen")
    else
      velocity = Fleet.get_velocity_from_array(ships)
      velocity = velocity * fleet.velocity_factor
      distance = planet1.getDistance(planet2)
      time = fleet.get_needed_time(velocity, distance)
      needed_energy = Fleet.get_needed_fuel_from_hash(ship_hash, time)
    end

    # Fehlersammlung
    begin      
      if ress_credit < 0 || ress_crystal < 0 || ress_ore < 0
        fehler.push("Fehlerhafte Eingabe der Ressourcen")
      end

      if planet1 == planet2
        fehler.push("Flotte muss zu einem anderen Planeten fliegen")
      end

      if needed_energy > planet1.energy
        fehler.push("Nicht genügend Energie")
      end
      
      unless fleet.enough_ships?(ship_hash)
        fehler.push("Nicht genügend Schiffe vorhanden")
      end
      
      if mission.id == 2 && !ship_hash.include?(Ship.find(10))
        fehler.push("Zum Kolonialisieren wird ein Kolonieschiff benötigt")
      end
      
      if mission.id == 5 && ship_hash != {Ship.find(7)=>1}
        fehler.push("Zum Spionieren, darf nur eine Spionagesonde gewählt werden")
      end

      if (ress_ore + ress_crystal + ress_credit) > fleet.get_free_capacity
        fehler.push("Zu wenig Platz in der Flotte vorhanden")
      end

      if ress_ore > planet1.ore
        fehler.push("nicht genug Erz vorhanden")
      end

      if ress_crystal > planet1.crystal
        fehler.push("nicht genug Kristall vorhanden")
      end

      if ress_credit > current_user.money
        fehler.push("nicht genug Space-Cash vorhanden")
      end

      if mission.id != 2 && mission.id != 6
        if ress_ore != 0 || ress_crystal != 0 || ress_credit != 0
          fehler.push("Ressourcen nur bei Kolonialisierung oder Transport erlaubt")
        end
      end
    rescue
      puts "FEHLER"
    end

    return fehler
  end

  # GET /confirm/send
  def send_fleet

    ship_hash = Hash.new
    Ship.all.each do |ship|
      if params["ship-#{ship.id}"]
        ship_hash[Ship.find(ship.id)] = params["ship-#{ship.id}"].to_i
      end
    end

    ress_ore = params.has_key?("ress-ore") ? params["ress-ore"].to_i : 0
    ress_crystal = params.has_key?("ress-crystal") ? params["ress-crystal"].to_i : 0
    ress_credit = params.has_key?("ress-credit") ? params["ress-credit"].to_i : 0
    
    if check_helper(params).empty?
      fleet = Fleet.find(params[:fleet])
      fleet.move(Mission.find(params[:mission]), Planet.find(params[:planet]), ship_hash, ress_ore, ress_crystal, ress_credit)
      redirect_to "/fleets"
    else
      redirect_to "/missions"
    end

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
