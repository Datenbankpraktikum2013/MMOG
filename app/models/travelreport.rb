class Travelreport < ActiveRecord::Base
	has_many :shipcounts, dependent: :delete_all
	has_many :ships, :through => :shipcounts
	has_one :report, as: :reportable

	# modes: 0 = Gegner
	# 		 1 = unbewohnter Planet
	#        2 = Allianzmitglied
	#        3 = eigener Planet
	def finish_travelreport(planet, fleet, mode)
		@r = Report.new
		self.report = @r

		self.mode = mode

		@r.defender = planet.user 
		@r.defender_planet = planet

		@r.attacker = fleet.user
		@r.attacker_planet = fleet.start_planet

		@r.receivers << planet.user  unless planet.user.nil?
		@r.receivers << fleet.user

		@r.fightdate = Time.at(fleet.arrival_time)

		add_fleet_info(fleet)

		self.save
		@r.save
	end

	def add_fleet_info(fleet)
		fleet.shipfleets.each do |shipfleet|
			tmp = Shipcount.new
			tmp.amount = shipfleet.amount
			tmp.ship = shipfleet.ship
			tmp.user = fleet.user
			self.shipcounts << tmp
		end
	end
end
