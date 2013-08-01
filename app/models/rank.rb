class Rank < ActiveRecord::Base

	validates_presence_of :name

	belongs_to :alliance

	validates :is_rank_name_taken, on: :create, on: :update

#check if rank name is taken
	def is_rank_name_taken
		@ranks=Rank.find_by_alliance_id(current_user.alliance_id)
		@ranks.each do |rank|
			if rank.name.downcase==:name.downcase
				errors.add :name "already exists in your alliance"
			end
		end		
	end

end
