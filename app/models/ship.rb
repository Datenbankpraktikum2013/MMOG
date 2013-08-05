class Ship < ActiveRecord::Base
	has_many :shipcounts
	has_many :shipfleets
	has_many :fleets, :through => :shipfleets
	has_many :battlereports, :through => :shipcounts
	has_and_belongs_to_many :buildingtypes
	has_and_belongs_to_many :technologies
end