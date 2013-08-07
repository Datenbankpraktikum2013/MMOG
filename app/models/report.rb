class Report < ActiveRecord::Base
	
	belongs_to :reportable, polymorphic: true, dependent: :destroy
	belongs_to :defender_planet, class_name: "Planet", foreign_key: "defender_planet_id"
	belongs_to :attacker_planet, class_name: "Planet", foreign_key: "attacker_planet_id"
	belongs_to :attacker, class_name: "User", foreign_key: "attacker_id"
	belongs_to :defender, class_name: "User", foreign_key: "defender_id"
	has_many :receiving_reports, dependent: :delete_all
	has_many :receivers, through: :receiving_reports, source: :user

#	scope :read, -> { where(read: true) }
#	scope :unread, -> { where(read: false) }


	def delete_receiver(user)
		con = self.receiving_reports.where(user: user).first

		unless con.nil?
			con.destroy
			if self.receiving_reports.count == 0
				self.destroy
			end
		end
	end
end
