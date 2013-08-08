class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  has_many :messages_users
  has_many :recipients, :class_name => 'User', :through => :messages_users, :source => :user

  def is_readable?(user)
  	return false if user==nil
  	return (user==self.sender or self.recipients.exists?(user)==1)
  end

  def tag_msg_as_seen!(user)
  	if(self.sender!=user)
    	@entry=MessagesUser.all.where(:user_id=>user,:message_id=>self).first
    	@entry.read=true
    	@entry.save
  	end
  end
end
