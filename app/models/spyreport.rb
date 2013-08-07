class Spyreport < ActiveRecord::Base
	has_many :shipcounts, dependent: :delete_all
	has_many :ships, :through => :shipcounts
	has_many :techstages, dependent: :delete_all
	has_many :technologies, :through => :techstages
	has_and_belongs_to_many :buildingtypes
	has_one :report, as: :reportable

	def finish_spyreport(planet, fleet)#, own_spy_factor, opp_spy_factor)
		@r = Report.new
		self.report = @r
		@r.defenders << planet.user
		@r.defender_planet = planet

		@r.attacker = fleet.user
		@r.attacker_planet = fleet.start_planet

		@r.fightdate = Time.at(fleet.arrival_time)

		self.energy = planet.energy
		self.population = planet.population
		self.ore = planet.ore
		self.crystal = planet.crystal
		self.space_cash = planet.user.money

		add_buildings

		add_ships

		add_tech

		self.save
		@r.save
	end

	def add_ships
		fleets = Fleet.where(start_planet: @r.defender_planet, target_planet: @r.defender_planet)

		fleets.each do |fleet|
			fleet.shipfleets.each do |shipfleet|
				tmp = Shipcount.new
				tmp.user = fleet.user
				tmp.ship = shipfleet.ship
				tmp.amount = shipfleet.amount
				self.shipcounts << tmp
			end
		end
	end

	def add_buildings
		Building.where(planet: @r.defender_planet).each do |building|
			self.buildingtypes << building.buildingtype
		end
	end

	def add_tech
		UserTechnology.where(user: @r.defenders.first).each do |tech|
			tmp = Techstage.new
			tmp.technology = tech.technology
			tmp.level = tech.rank
			self.techstages << tmp
		end
	end

	def self.test
		s = Spyreport.new
		p = Planet.find(1)
		f = Fleet.find(1)
		s.finish_spyreport(p, f)
	end

end
