class Alliance < ActiveRecord::Base
	
	validates_presence_of :name

	has_many :ranks

	validate :is_alliance_name_taken


	def is_alliance_name_taken
		if Alliance.exists?(:name => name)
		errors.add :name, "is already taken"
		end
	end		
end
