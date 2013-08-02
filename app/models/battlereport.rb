class Battlereport < ActiveRecord::Base
	has_many :shipcounts
	has_many :ships, :through => :shipcounts
	belongs_to :defender_planet, class_name: "Planet", foreign_key: "defender_planet_id"
	belongs_to :attacker_planet, class_name: "Planet", foreign_key: "attacker_planet_id"
	belongs_to :winner, class_name: "User", foreign_key: "winner_id"
	belongs_to :defender, class_name: "User", foreign_key: "defender_id"
	belongs_to :attacker, class_name: "User", foreign_key: "attacker_id"

	def add_defender_pre(fleet)
		self.defender = fleet.user
		self.defender_planet = fleet.start_planet

		fleet.shipfleets.each do |shipfleet|

			tmp = Shipcount.new
			tmp.amount = shipfleet.amount
			tmp.ship = shipfleet.ship
			tmp.shipowner_time_type = 0
			tmp.save
			self.shipcounts << tmp
		end
	end

	def add_attacker_pre(fleet)
		self.attacker = fleet.user
		self.attacker_planet = fleet.start_planet

		fleet.shipfleets.each do |shipfleet|

			tmp = Shipcount.new
			tmp.amount = shipfleet.amount
			tmp.ship = shipfleet.ship
			tmp.shipowner_time_type = 1
			tmp.save
			self.shipcounts << tmp
		end
	end

	def add_defender_after(fleet, winner=false)

		if winner
			self.winner = fleet.user
		end

		fleet.shipfleets.each do |shipfleet|

			tmp = Shipcount.new
			tmp.amount = shipfleet.amount
			tmp.ship = shipfleet.ship
			tmp.shipowner_time_type = 2
			tmp.save
			self.shipcounts << tmp
		end
	end

	def add_attacker_after(fleet, winner=false)

		if winner
			self.winner = fleet.user
		end

		fleet.shipfleets.each do |shipfleet|

			tmp = Shipcount.new
			tmp.amount = shipfleet.amount
			tmp.ship = shipfleet.ship
			tmp.shipowner_time_type = 3
			tmp.save
			self.shipcounts << tmp
		end
	end
end