class Request < ActiveRecord::Base
  after_create :calculate_requestvalue!
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => 'User', :foreign_key => 'recipient_id'
  validates_presence_of :sender_id,:recipient_id

  private
  	def calculate_requestvalue!()
  		self.requestvalue=Digest::SHA1.hexdigest([Time.now, rand].join)
  		self.save
  	end

  public
  	def decide_notify()
  		if self.action=="alliance_invite"
  			self.recipient.system_notify("Allianzeinladung","Die Allianz "+self.sender.alliance.name+" würde gerne zusammen mit dir spielen!"  				,"Hallo! "+self.sender.username+" hat dich eingeladen, seiner Allianz beizutreten. Für was entscheidest du dich?<br><a class=\"label label-success\" data-method=\"post\" href=\"/requests/reaction/?answer=yes&for="+self.requestvalue+"\" rel=\"nofollow\" style=\"color:#FFFFFF;\">Annehmen</a><a class=\"label label-warning\" data-method=\"post\" href=\"/requests/reaction/?answer=no&for="+self.requestvalue+"\" rel=\"nofollow\" style=\"color:#FFFFFF;\">Ablehnen</a> ")
      end
  	end

  public
    def accept()
      
    end
end
