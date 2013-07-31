class Shipfleet < ActiveRecord::Base
	belongs_to :fleet
	belongs_to :ship, autosave: true
end
