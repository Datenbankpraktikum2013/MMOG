class Battlereport < ActiveRecord::Base
	has_many :shipcounts, dependent: :delete_all
	has_many :ships, :through => :shipcounts
	belongs_to :winner, class_name: "User", foreign_key: "winner_id"
	has_one :report, as: :reportable

	def init_battlereport(def_fleet, atk_fleet)
		@r = Report.new
		self.report = @r

		@r.defender = def_fleet.user
		@r.defender_planet = def_fleet.start_planet

		@r.attacker = atk_fleet.user
		@r.attacker_planet = atk_fleet.start_planet

		@r.fightdate = Time.at(atk_fleet.arrival_time)

		self.add_fleet_info(def_fleet, 0)
		self.add_fleet_info(atk_fleet, 1)

		
	end

	def finish_battlereport(def_fleet, atk_fleet, defended=false)
		self.add_fleet_info(def_fleet, 2)
		self.add_fleet_info(atk_fleet, 3)

		defended ? self.winner = def_fleet.user : self.winner = atk_fleet.user
		self.save
		self.report.save
	end

	def add_fleet_info(fleet, type)
		fleet.shipfleets.each do |shipfleet|
			tmp = Shipcount.new
			tmp.amount = shipfleet.amount
			tmp.ship = shipfleet.ship
			tmp.shipowner_time_type = type
			self.shipcounts << tmp
		end
	end
end