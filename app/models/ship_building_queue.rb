class ShipBuildingQueue < ActiveRecord::Base
	belongs_to :ship
	belongs_to :planet

	def self.insert(s,p)
		crystal_cost=0
		ore_cost=0
		credit_cost=0
		crew_capacity=0
		s.each do |key, value|
			unless(value.to_i.zero?)
				# puts "xxxxxxxxxxxxxxxxx c #{key.crystal_cost} xxx #{value}"
				# puts "xxxxxxxxxxxxxxxxx  #{key.ore_cost} xxx #{value}"
				crystal_cost+=(key.crystal_cost.to_i * value.to_i)
				ore_cost+=(key.ore_cost.to_i * value.to_i)
				credit_cost+=(key.credit_cost.to_i * value.to_i)
				crew_capacity+=(key.crew_capacity.to_i * value.to_i)
			end
		end

		o=p.take(:Ore, ore_cost)
		c=p.take(:Crystal, crystal_cost)
		m=p.take(:Money, credit_cost)
		crew=p.take(:Population, crew_capacity)

		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts ("o #{o}=#{ore_cost}, c: #{c}=#{crystal_cost}, m: #{m}=#{credit_cost}")
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		# puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		if((o==ore_cost) && (m==credit_cost) && (c==crystal_cost) && (crew==crew_capacity))
			s.each do |key, value|
				unless(value.to_i.zero?)
					# puts ">>>>>>>>>>>>>>>>>>>>>>>> #{value.to_i}"
					q_ary=Array.new
					last_q=ShipBuildingQueue.last
					if last_q.nil?
						l_qid=0
						plus=Time.now.to_i;
					else
						l_qid=last_q.qid+1
						plus=ShipBuildingQueue.where(planet_id: p.id).last
						if plus.nil?
							plus=Time.now.to_i 
						else plus=plus.end_time
						end
					end
					value.to_i.times do |i|
						q=self.new
						q.ship=key
						q.planet=p 
						q.qid=l_qid

						if i==0
							q.end_time=key.construction_time+plus
						else
							q.end_time=key.construction_time + q_ary[i-1].end_time
						end
						puts "00000000000000000000000000000000000000"
						puts "Adding Ship #{q.ship.id }to Planet"
						puts "Now: #{Time.now.to_i} End: #{Time.at(q.end_time)}"
						q_ary[i]=q
						Fleet.add_ship_in(q.end_time, q.ship, q.planet, q.qid)
						l_qid+=1
					end

					
					

					ActiveRecord::Base.transaction do
	  					value.to_i.times  do |i| 
							#puts "<<<<<<<<<<<<<<<<<<<<t=#{q_ary[i].end_time} id=#{q_ary[i].id} qid=#{q_ary[i].qid}"

	  						#Model.create(options)
	  						ShipBuildingQueue.create(:ship => q_ary[i].ship, :planet=>q_ary[i].planet,:end_time=>q_ary[i].end_time,:qid=>q_ary[i].qid) 
	  					end
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
			p.give(:Population,crew)
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

		
		Resque.remove_delayed(AddShip, self.ship_id, self.planet_id, self.qid )
		del_ship_type=Ship.find(self.ship_id)
		ShipBuildingQueue.update_time(end_time, planet,del_ship_type.construction_time)
		pl=Planet.find(self.planet_id)

		o1=pl.give(:Ore, del_ship_type.ore_cost)
		c1=pl.give(:Crystal, del_ship_type.crystal_cost)
		m1=pl.give(:Money, del_ship_type.crystal_cost)
		cr1=pl.give(:Population, del_ship_type.crew_capacity)

		


		self.destroy
	end

	def self.update_time(t,p,b)
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "|||||||||||||||||aaaaaaaaaaaaaaaaaaaaaaaaaaa||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		queue=self.where("planet_id=? AND end_time>?", p,t).includes(:ship,:planet).to_a
		# q3=queue.where("end_time<?", t).maximum("end_time")
		# if q3.nil? 
		# 	q3=Time.now.to_i
		# end
		
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "|||||||||||||||||bbbbbbbbbbbbbbbbbbbbbbbbbbb||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"


		queue.each do |q|
			
				# q2=self.new
				# q2.ship_id=q.ship_id
				# q2.planet_id=q.planet_id
				puts "#{q.id}"
				q.end_time-=b
				
				x=Resque.remove_delayed(AddShip, q.ship_id, q.planet_id, q.qid )
				puts x
				Fleet.add_ship_in(q.end_time, q.ship, q.planet, q.qid)
				
				
			

		end
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "|||||||||||||||||ccccccccccccccccccccccccccc||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		plid=p.id
		ShipBuildingQueue.update_all("end_time= end_time - #{b}","planet_id=#{plid} AND end_time>#{t}")

	end
end
