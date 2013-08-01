class Rank < ActiveRecord::Base

	validates_presence_of :name

	belongs_to :alliance

	validate :is_rank_name_taken, on: :create

#check if rank name is taken
	def is_rank_name_taken
		@ranks=alliance.ranks
		@ranks.each do |r|
			if r.name.downcase==name.downcase
				errors.add :name,"already exists in your alliance"
			end
		end	
	end
end
