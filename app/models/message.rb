class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  has_many :messages_user
  has_many :recipients, :class_name => 'User', :through => :messages_user, :source => :user
end
