class UseroverviewController < ApplicationController
	def useroverview
		@users=User.all(:order => "score DESC")
	end
end