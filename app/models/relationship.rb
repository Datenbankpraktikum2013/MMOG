class Relationship < ActiveRecord::Base
	belongs_to :user, class_name: 'User'
  	belongs_to :friend, class_name: 'User'

  	public
  		def delete_permission?(user)
  			return (user==self.user or user==self.friend)
  		end
end
