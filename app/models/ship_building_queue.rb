class ShipBuildingQueue < ActiveRecord::Base
	belongs_to :ship
	belongs_to :planet

	def self.insert(s,p)
		q=self.new
		q.ship=s 
		q.planet=p 
		q.end_time=s.construction_time + self.get_time(p)
		puts "Now: #{Time.now.to_i} End: #{q.end_time}"
		q.save
		Fleet.add_ship_in(q.end_time, q.ship, q.planet, q.id)
	end

	def self.get_time(p)
		if self.where(planet: p).last.nil?
			Time.now.to_i
		else
			self.where(planet: p).maximum("end_time").to_i
		end

	end
end
