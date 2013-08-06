class Spyreport < ActiveRecord::Base
	has_many :shipcounts, dependent: :delete_all
	has_many :ships, :through => :shipcounts
	has_many :techstages, dependent: :delete_all
	has_many :technologies, :through => :techstages
	has_and_belongs_to_many :buildingtypes

	def finish_spyreport(planet, fleet, own_spy_factor, opp_spy_factor)
		@r = Report.new
		self.report = @r

		@r.defender = planet.user
		@r.defender_planet = planet

		@r.attacker = fleet.user
		@r.attacker_planet = fleet.start_planet

		@r.fightdate = Time.at(atk_fleet.arrival_time)

		self.energy = planet.energy
		self.population = planet.population
		self.ore = planet.ore
		self.crystal = planet.crystal
		self.cash = planet.user.money

		add_buildings




	end

	def add_ships
		tmp = Hash.new(0)

		fleets =  Fleet.where(:startplanet self.planet, :target_planet self.planet)

		fleets.each do |fleet|
			fleet.shipfleets.each do |shipfleet|
				tmp[shipfleet.ship_id] += shipfleet.amount
			end
		end

		tmp.each do |ship_id, amoount|
			sc = Shipcount.new
			sc.ship_id = ship_id
			sc.
		end
	end

	def add_buildings
		Buildingtype.where(:planet_id => planet.id).each do |buidling|
			self.buildingtypes << building
		end
	end

	def add_tech

	end
end
