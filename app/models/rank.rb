class Rank < ActiveRecord::Base

	validates_presence_of :name

	belongs_to :alliance

	has_many :users

	#validate :is_rank_name_taken, on: :create, on: :update
	validate :is_rank_name_taken, on: :create

#check if rank name is taken
	def is_rank_name_taken
		@ranks=self.alliance.ranks
		@ranks.each do |r|
			if r.name.downcase==self.name.downcase
				errors.add :name,"already exists in your alliance"
			end
		end	
	end
end
