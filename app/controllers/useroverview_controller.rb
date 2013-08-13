class UseroverviewController < ApplicationController
	
	before_filter :authenticate_user!

	def useroverview
		@users=User.all(:order => "score DESC")
	end
end