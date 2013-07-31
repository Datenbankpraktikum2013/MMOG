class Ship < ActiveRecord::Base
	has_many :shipfleets
	has_many :fleets, :through => :shipfleets
	has_and_belongs_to_many :buildingtypes
	has_and_belongs_to_many :technologies

	def save(*)
		create_or_update
			if (self.has_attribute? :amount && self.has_attribute? :fleet_id)
			sf = Shipfleet.where(fleet_id: self.fleet_id, ship_id: self.id).first
			sf.amount = self.amount
			sf.save
		end
		rescue ActiveRecord::RecordInvalid
  		false
	end

	def save!(*)

		create_or_update || raise(RecordNotSaved)
			if (self.has_attribute? :amount && self.has_attribute? :fleet_id)
			sf = Shipfleet.where(fleet_id: self.fleet_id, ship_id: self.id).first
			sf.amount = self.amount
			sf.save!
		end
	end
end