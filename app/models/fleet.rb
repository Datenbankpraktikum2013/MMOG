class Fleet < ActiveRecord::Base
	has_many :shipfleets
	has_many :ships, :through => :shipfleets, :select => "ships.*, shipfleets.amount"
	belongs_to :start_planet, class_name: "Planet", foreign_key: "start_planet"
	belongs_to :target_planet, class_name: "Planet", foreign_key: "target_planet"
	belongs_to :user
	belongs_to :mission

  # static Method that returns a ?set? of fleets that correspond to either a planet
  # or a user
  def self.get_fleets(p)
    if p.is_a?Planet then
      Fleet.where(start_planet: p, target_planet: p)
    elsif p.is_a?User then
      Fleet.where(user_id: p)
    end
  end

  # static method that gets one fleet object
  def self.get_fleet(user, planet)
    if planet.is_a?Planet and user.is_a?User then
      Fleet.where(start_planet: planet, target_planet: planet, user_id: user)
    end
  end

  # liefert die Menge eines Schifftyps in einer Flotte
  def get_amount_of_ship(ship_id)
    var = self.ships.find(ship_id)
    if var = nil then
      return null
    else
      return var.amount
    end
  end

  # liefert alle schiffe einer Flotte zurück
  def get_ships()
    #HASH MIT AMOUNTS!!!!!!!!!!!!
    return self.ships
  end

=begin
  # fuegt einer Flotte ein Schiff hinzu
  def add_ship(ship)
    if ship.is_a?Ship then
      self.ships << ship
      #GEHT DIESE AENDERUNG?
      fid = self.fleet_id 
      sid = ship.ship_id
      # first is necessary because the return value is a collection with one object
      Shipfleet.where(fleet_id: fid, ship_id: sid).first.amount += 1
      #GEHT DIESE AENDERUNG?
    end
  end
=end


end
