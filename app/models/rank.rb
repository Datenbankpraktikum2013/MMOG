class Rank < ActiveRecord::Base

	validates_presence_of :name

	belongs_to :alliance

end
