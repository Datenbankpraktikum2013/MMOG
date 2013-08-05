class Report < ActiveRecord::Base
  belongs_to :reportable
  belongs_to :defender_planet
  belongs_to :attacker_planet
  belongs_to :defender
  belongs_to :attacker
end
