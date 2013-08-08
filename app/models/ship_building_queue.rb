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

	def remove_queue

		Resque.remove_delayed(AddShip, self.ship_id, self.planet_id, self.id )
		ShipBuildingQueue.update_time(end_time, planet)
		self.destroy
	end

	def self.update_time(t,p)
		queue=self.where(planet: p)
		queue.each do |q|
			if q.end_time > t
				q2=self.new
				q2.ship_id=q.ship_id
				q2.planet_id=q.planet_id
				q3=queue.where("end_time<?", t).maximum("end_time")
				if q3.nil? 
					q3=Time.now.to_i
				end
				q2.end_time=(Time.now.to_i + (q.end_time-t))+(q3 - Time.now.to_i)
				q2.save
				Resque.remove_delayed(AddShip, q.ship_id, q.planet_id, q.id )
				Fleet.add_ship_in(q2.end_time, q2.ship, q2.planet, q2.id)
				q.destroy
				
			end

		end

	end
end
