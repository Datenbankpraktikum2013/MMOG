class Battlereport < ActiveRecord::Base
	has_many :shipcounts, dependent: :delete_all
	has_many :ships, :through => :shipcounts
	belongs_to :winner, class_name: "User", foreign_key: "winner_id"
	has_one :report, as: :reportable

	def init_battlereport(def_fleets, atk_fleet)
		@r = Report.new
		self.report = @r

		@r.defender_planet = def_fleets.first.start_planet
		@r.defender = @r.defender_planet.user

		@r.attacker = atk_fleet.user
		@r.attacker_planet = atk_fleet.start_planet

		@r.fightdate = Time.at(atk_fleet.arrival_time)

		def_fleets.each do |fleet|
			@r.receivers << fleet.user
			self.add_fleet_info(fleet, 0)
		end

		@r.receivers << atk_fleet.user
		self.add_fleet_info(atk_fleet, 1)
	end

	def finish_battlereport(def_fleets, atk_fleet, defended=false)
		def_fleets.each do |fleet|
			self.add_fleet_info(fleet, 2)
		end
		self.add_fleet_info(atk_fleet, 3)

		defended ? self.winner = @r.defender_planet.user : self.winner = atk_fleet.user
		self.save
		@r.save
	end

	def add_fleet_info(fleet, type)
		fleet.shipfleets.each do |shipfleet|
			tmp = Shipcount.new
			tmp.amount = shipfleet.amount
			tmp.ship = shipfleet.ship
			tmp.shipowner_time_type = type
			tmp.user = fleet.user
			self.shipcounts << tmp
		end
	end
end