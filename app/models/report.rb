class Report < ActiveRecord::Base
	belongs_to :reportable, polymorphic: true, dependent: :destroy
	belongs_to :defender_planet, class_name: "Planet", foreign_key: "defender_planet_id"
	belongs_to :attacker_planet, class_name: "Planet", foreign_key: "attacker_planet_id"
	belongs_to :attacker, class_name: "User", foreign_key: "attacker_id"
	has_and_belongs_to_many :defenders, class_name: "User", join_table: "reports_users"

	scope :read, -> { where(read: true) }
	scope :unread, -> { where(read: false) }
end
