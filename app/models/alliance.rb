class Alliance < ActiveRecord::Base
	#callback after save operation
	after_save :create_default_ranks, on: :create

	validates_presence_of :name

	has_many :ranks

	has_many :users

	validate :is_alliance_name_taken, on: :create

#checks if alliance name is already taken
	def is_alliance_name_taken
		if Alliance.exists?(:name.downcase => name.downcase)
			errors.add :name, "is already taken"
		end
	end

	#create default ranks
	private
	def create_default_ranks
		#create default founder rank
      	self.ranks.create(:name=>"Anwärter",:standard=>true)
      	self.ranks.create(:name => "Oberhaupt",:can_kick=>true,:can_massmail=>true,:can_edit=>true,:can_invite=>true,:is_founder=>true,:can_disband=>true)
	end

	public
	def set_founder(founder)
		#get founder rank
		@rank=self.ranks.where(:is_founder=>true).first
		#add user to this rank
		@rank.users<<founder
		#add user to alliance
		self.users<<founder
	end		

	#add user to alliance and set default rank
	public
	def add_user(user)
		if user.alliance==nil
			self.users<<user
			@def=self.ranks.where(:standard=>true).first
			@def.users<<user
			return true
		end
		return false
	end

	#removes a user from the alliance
	public
	def remove_user(user)
		if user.alliance==self
			self.users.delete(user)
			user.rank.users.delete(user)
			return true
		end
		return false
	end

	#changes default rank of alliance
	public
	def change_default_rank(rank)
		if rank == nil
			return false
		end
		@old=self.ranks.where(:standard=>true).first
		@old.standard=false
		@old.save
		rank.standard=true
		rank.save
		return true
	end

	#changes user rank
	public
	def change_user_rank(user,rank)
		if rank == nil
			return false
		end
		rank.users<<user
		return true
	end
end
