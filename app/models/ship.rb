class Ship < ActiveRecord::Base
	has_many :shipcounts
	has_many :shipfleets
	has_many :fleets, :through => :shipfleets
	has_many :battlereports, :through => :shipcounts
	has_and_belongs_to_many :buildingtypes
	has_and_belongs_to_many :technologies

	# returns a {Shipname => level} hash
	def get_prerequisites
		building_hash = Hash.new

		buildingtypes = self.buildingtypes
		buildingtypes.each do |buildingtype|
			building_hash[buildingtype.name] = buildingtype.level
		end
		building_hash
	end

=begin
	def save(*)
		create_or_update
			if self.has_attribute? :amount
			sf = Shipfleet.where(fleet_id: self.fleet_id, ship_id: self.id).first
			sf.amount = self.amount
			sf.save
		end
		rescue ActiveRecord::RecordInvalid
  		false
	end

	def save!(*)

		create_or_update || raise(RecordNotSaved)
			if self.has_attribute? :amount
			sf = Shipfleet.where(fleet_id: self.fleet_id, ship_id: self.id).first
			sf.amount = self.amount
			sf.save!
		end
	end
=end
end