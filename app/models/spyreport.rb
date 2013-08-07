class Spyreport < ActiveRecord::Base
	has_many :shipcounts, dependent: :delete_all
	has_many :ships, :through => :shipcounts
	has_many :techstages, dependent: :delete_all
	has_many :technologies, :through => :techstages
	has_and_belongs_to_many :buildingtypes
	has_one :report, as: :reportable

	# types: 0 = Gegner
	# 		 1 = unbewohnter Planet
	#        2 = Allianzmitglied
	#        3 = eigener Planet
	#        4 = sonde beim versuch zerstört
	def finish_spyreport(planet, fleet, atk_spy_factor, def_spy_factor, mode)

		self.calc_spylevel(atk_spy_factor, def_spy_factor)

		@r = Report.new
		self.mode = mode
		self.report = @r
		@r.defender = planet.user
		@r.defender_planet = planet

		@r.attacker = fleet.user
		@r.attacker_planet = fleet.start_planet

		@r.receivers << planet.user
		@r.receivers << fleet.user

		@r.fightdate = Time.at(fleet.arrival_time)
		if mode < 2
			unless spylevel < 1
				self.energy = planet.energy
				self.population = planet.population
				self.ore = planet.ore
				self.crystal = planet.crystal
				self.space_cash = planet.user.money
			end

			if mode < 1
				unless self.spylevel < 2
					self.add_buildings
				end

				unless self.spylevel < 4
					self.add_ships
				end	

				unless self.spylevel < 3
					self.add_tech
				end
			end
		end

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
		UserTechnology.where(user: @r.defender).each do |tech|
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
		s.finish_spyreport(p, f, 1, 2, 0)
	end

	def calc_spylevel(atk_spy_factor, def_spy_factor)
		tmp = def_spy_factor - atk_spy_factor

		r = rand 0.8..1.2

		tmp *= r

		tmp = (tmp + 1)* 0.5

		if tmp > 0.7
			self.spylevel = 4
		elsif tmp > 0.5
			self.spylevel = 3
		elsif tmp > 0.3
			self.spylevel = 2
		elsif tmp > 0.05
			self.spylevel = 1
		else
			self.spylevel = 0
		end		
	end
end
