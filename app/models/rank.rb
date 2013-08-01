class Rank < ActiveRecord::Base

	validates_presence_of :name

	belongs_to :alliance

	#validate :is_rank_name_taken, on: :create, on: :update

#check if rank name is taken
	def is_rank_name_taken
		
			errors.add :name, " already exists in your alliance"
			
	end
end
