class Battlereport < ActiveRecord::Base
	has_many :ships, :through => :shipcounts
	belongs_to :defender_planet, class_name: "Planet", foreign_key: "defender_planet_id"
	belongs_to :attacker_planet, class_name: "Planet", foreign_key: "attacker_planet_id"
	belongs_to :winner, class_name: "User", foreign_key: "winner_id"
	belongs_to :defender, class_name: "User", foreign_key: "defender_id"
	belongs_to :attacker, class_name: "User", foreign_key: "attacker_id"
end
