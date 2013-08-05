class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  has_and_belongs_to_many :recipients, :class_name => 'User', :association_foreign_key => 'recipient_id'
end
