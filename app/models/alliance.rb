class Alliance < ActiveRecord::Base
	
	after_save :create_default_ranks

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

	private
	def create_default_ranks
		self.ranks.create(:name => "Oberhaupt",:can_kick=>true,:can_massmail=>true,:can_edit=>true,:can_invite=>true,:is_founder=>true,:can_disband=>true)
      	self.ranks.create(:name=>"Anwärter")
	end

	public
	def set_founder(founder)
		@rank=self.ranks.where(:is_founder=>true).first
		@rank.users<<founder
		self.users<<founder
		return (founder.save and self.ranks.first.save)
	end		
end
