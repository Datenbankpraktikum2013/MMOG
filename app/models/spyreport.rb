class Spyreport < ActiveRecord::Base
	has_many :shipcounts, dependent: :delete_all
	has_many :ships, :through => :shipcounts
	has_many :techstages, dependent: :delete_all
	has_many :technologies, :through => :techstages
	has_and_belongs_to_many :buildingtypes

	def finish_spyreport(planet, spy)
		self.energy = planet.energy
		self.population = planet.population
		self.ore = planet.ore
		self.crystal = planet.crystal
		self.cash = planet.user.money

		add_buildings




	end

	def add_ships
		
	end

	def add_buildings
		Buildingtype.where(:planet_id => planet.id).each do |buidling|
			self.buildingtypes << building
		end
	end

	def add_tech

	end
end
