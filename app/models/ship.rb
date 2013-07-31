class Ship < ActiveRecord::Base
	has_many :shipfleets
	has_many :fleets, :through => :shipfleets
	has_and_belongs_to_many :buildings
	has_and_belongs_to_many :technologies
end
