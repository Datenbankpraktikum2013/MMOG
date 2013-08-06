class Shipcount < ActiveRecord::Base
	belongs_to :battlereport
	belongs_to :spyreport
	belongs_to :ship
	belongs_to :user
end
