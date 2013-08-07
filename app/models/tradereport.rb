class Tradereport < ActiveRecord::Base
	has_one :report, as: :reportable

	def finish_tradereport(fleet, planet)
		r = Report.new
		self.report = r

		r.defender << planet.user
		r.defender_planet = planet

		r.attacker = fleet.user
		r.attacker_planet = fleet.start_planet

		r.receivers << planet.user
		r.receivers << fleet.user

		r.fightdate = Time.at(fleet.arrival_time)

		self.ore = fleet.ore
		self.crystal = fleet.crystal
		self.space_cash = fleet.credit

		self.save
		r.save
	end
end
