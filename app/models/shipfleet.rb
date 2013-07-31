class Shipfleet < ActiveRecord::Base
	belongs_to :fleet
	belongs_to :ship

	def self.get_amount(fleet, ship)
		var = (Shipfleet.where(fleet: fleet, ship: ship)).first
		if var == nil
			0
		elsif
			var.amount
		end
	end

end
