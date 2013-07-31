class Fleet < ActiveRecord::Base
	has_many :shipfleets
	has_many :ships, :through => :shipfleets
	belongs_to :start_planet, class_name: "Planet"
	belongs_to :start_planet, class_name: "Planet"
	belongs_to :user
	belongs_to :mission
end
