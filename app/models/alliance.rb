class Alliance < ActiveRecord::Base
	
	validates_presence_of :name

	has_many :ranks
end
