class Report < ActiveRecord::Base
	belongs_to :reportable, polymorphic: true, dependent: :destroy
	belongs_to :defender_planet, class_name: "Planet", foreign_key: "defender_planet_id"
	belongs_to :attacker_planet, class_name: "Planet", foreign_key: "attacker_planet_id"
	belongs_to :defender, class_name: "User", foreign_key: "defender_id"
	belongs_to :attacker, class_name: "User", foreign_key: "attacker_id"

	scope :read, -> { where(read: true) }
	scope :unread, -> { where(read: false) }
end
