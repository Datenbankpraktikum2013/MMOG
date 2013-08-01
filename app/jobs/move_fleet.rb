#require "/app/models/fleet

class MoveFleet
	@queue = "workqueue"
	def self.perform()
		puts "geht"
	end
end
