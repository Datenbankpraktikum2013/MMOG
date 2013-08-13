class ShipBuildingQueue < ActiveRecord::Base
	belongs_to :ship
	belongs_to :planet

	def self.insert(s,p)
		crystal_cost=0
		ore_cost=0
		credit_cost=0
		s.each do |key, value|
			unless(value.to_i.zero?)
				# puts "xxxxxxxxxxxxxxxxx c #{key.crystal_cost} xxx #{value}"
				# puts "xxxxxxxxxxxxxxxxx  #{key.ore_cost} xxx #{value}"
				crystal_cost+=(key.crystal_cost.to_i * value.to_i)
				ore_cost+=(key.ore_cost.to_i * value.to_i)
				credit_cost+=(key.credit_cost.to_i * value.to_i)
			end
		end

		o=p.take(:Ore, ore_cost)
		c=p.take(:Crystal, crystal_cost)
		m=p.take(:Money, credit_cost)

		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts ("o #{o}=#{ore_cost}, c: #{c}=#{crystal_cost}, m: #{m}=#{credit_cost}")
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		if((o==ore_cost) && (m==credit_cost) && (c==crystal_cost))
			s.each do |key, value|
				unless(value.to_i.zero?)
					# puts ">>>>>>>>>>>>>>>>>>>>>>>> #{value.to_i}"
					value.to_i.times do
						q=self.new
						q.ship=key
						q.planet=p 
						q.end_time=key.construction_time + self.get_time(p)
						# puts "00000000000000000000000000000000000000"
						# puts "Adding Ship #{q.ship.id }to Planet"
						# puts "Now: #{Time.now.to_i} End: #{q.end_time}"
						q.save
						Fleet.add_ship_in(q.end_time, q.ship, q.planet, q.id)
						
					end
				end
			end
			return true
		else
			# puts "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ"
			# puts "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ"
			# puts "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ"

			# puts "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ"
			# puts "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ"
			# puts "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ"
			p.give(:Ore,o)
			p.give(:Crystal,c)
			p.give(:Money,m)
			return false
		end


		# q=self.new
		# q.ship=s 
		# q.planet=p 
		# q.end_time=s.construction_time + self.get_time(p)
		# puts "Now: #{Time.now.to_i} End: #{q.end_time}"
		# q.save
		# Fleet.add_ship_in(q.end_time, q.ship, q.planet, q.id)
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
		queue=self.where("planet_id=? AND end_time>?", p,t)
		q3=queue.where("end_time<?", t).maximum("end_time")
		if q3.nil? 
			q3=Time.now.to_i
		end
		queue.each do |q|
			
				q2=self.new
				q2.ship_id=q.ship_id
				q2.planet_id=q.planet_id

				q2.end_time=(Time.now.to_i + (q.end_time-t))+(q3 - Time.now.to_i)
				q2.save
				Resque.remove_delayed(AddShip, q.ship_id, q.planet_id, q.id )
				Fleet.add_ship_in(q2.end_time, q2.ship, q2.planet, q2.id)
				q.destroy
				
			

		end

	end
end
