class Shipcount < ActiveRecord::Base
	belongs_to :battlereport
	belongs_to :ship
end
