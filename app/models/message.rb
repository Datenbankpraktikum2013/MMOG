class Message < ActiveRecord::Base

	validates_presence_of :text
	validates_presence_of :subject

	belongs_to :user
	has_many   :users

end
