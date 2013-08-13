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
      	self.ranks.create(:name => "Oberhaupt",:can_kick=>true,:can_massmail=>true,:can_edit_ranks=>true,:can_invite=>true,:is_founder=>true,:can_disband=>true,:can_change_description => true)
	end

	public
	def set_founder(founder)
		#get founder rank
		@rank=self.ranks.where(:is_founder=>true).first
		#add user to this rank
		@rank.users<<founder
	end

	public
	def add_score(value)
	    self.update_attribute(:score, score + value)
	end		

	#add user to alliance and set default rank
	public
	def add_user(user)
		return false if user==nil
		if user.alliance==nil
			self.users<<user
			@def=self.ranks.where(:standard=>true).first
			@def.users<<user
			self.add_score(user.score)
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
			self.add_score((-1)*user.score)
			return true
		end
		return false
	end

	#changes default rank of alliance
	public
	def change_default_rank(rank)
		@old=self.ranks.where(:standard=>true).first
		if rank == nil or rank==@old or rank.is_founder
			return false
		end
		@old.standard=false
		@old.save
		rank.standard=true
		rank.save
		return true
	end

	#changes user rank
	public
	def change_user_rank(user,rank)
		if rank == nil or user.alliance==nil or rank.is_founder
			return false
		end
		rank.users<<user
		return true
	end

	#set description
	public
	def set_description(description)
		self.description=description
		self.save
		return true
	end

	public
	def send_mass_mail(user, subject, body)
		if user==nil or subject==nil or body==nil
			return false
		end
		unless user.rank.can_massmail
			return false
		end
		@msg = user.sent_messages.create(:subject => subject, :body => body)
		@users = self.users.where.not(:id=>user)
		@users.each do |u|
			u.messages<<@msg
		end
		return true
	end

  	public
  		#check for userpermission on specific action
	  	def permission?(user,action)
		    #neither user nor user.rank can be nil for this
		    return false if user==nil or user.rank==nil
		    #user needs to be in the same alliance
		    return false unless same_alliance?(user)
		    if action=="edit_ranks"
		    	return can_edit_ranks?(user)
		    elsif action=="change_description"
		    	return can_change_description?(user)
		    elsif action=="massmail"
		    	return can_massmail?(user)
		    elsif action=="invite"
		    	return can_invite?(user)
		    elsif action=="kick"
		    	return can_kick?(user)
		    elsif action=="show_edit"
		    	return can_see_edit?(user)
		    elsif action=="destroy"
		    	return user.rank.is_founder
		    end
		    return false
	  	end

	private
		def can_see_edit?(user)
			return false if same_alliance?(user)==false
			return (can_edit_ranks?(user) or can_change_description?(user) or can_massmail?(user) or can_invite?(user) or can_kick?(user))
		end

  	private
	    def same_alliance?(user)
	      	return false if user==nil or user.rank==nil
	      	return (user.alliance==self)
	    end

	private
	    def can_edit_ranks?(user)
	      	return false if user==nil or user.rank==nil
	      	return user.rank.can_edit_ranks
	    end

	private
		def can_change_description?(user)
			return false if user==nil or user.rank==nil
			return user.rank.can_change_description
		end

	private
		def can_massmail?(user)
			return false if user==nil or user.rank==nil
			return user.rank.can_massmail
		end

	private
		def can_invite?(user)
			return false if user==nil or user.rank==nil
			return user.rank.can_invite
		end

	private
		def can_kick?(user)
			return false if user==nil or user.rank==nil
			return user.rank.can_kick
		end
end
