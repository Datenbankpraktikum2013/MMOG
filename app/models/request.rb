class Request < ActiveRecord::Base
  after_create :calculate_requestvalue!
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => 'User', :foreign_key => 'recipient_id'
  validates_presence_of :sender_id,:recipient_id

  @@actions=Hash.new
  private
  	def calculate_requestvalue!()
  		self.requestvalue=Digest::SHA1.hexdigest([Time.now, rand].join)
  		self.save
  	end

  public
  	def decide_notify()
      answerbutton="Für was entscheidest du dich? <br><a class=\"label label-success\" data-method=\"post\" href=\"/requests/reaction/?answer=yes&for="+self.requestvalue+"\" rel=\"nofollow\" style=\"color:#FFFFFF;\">Annehmen</a><a class=\"label label-warning\" data-method=\"post\" href=\"/requests/reaction/?answer=no&for="+self.requestvalue+"\" rel=\"nofollow\" style=\"color:#FFFFFF;\">Ablehnen</a> "
  		if self.action=="alliance_invite"
  			self.recipient.system_notify("Allianzeinladung","Die Allianz "+self.sender.alliance.name+" würde gerne zusammen mit dir spielen!"  				,answerbutton)
      elsif self.action=="friendship_invite"
        self.recipient.system_notify("Freundschaftsanfrage",self.sender.username,"Hallo! "+self.sender.username+" würde gerne mit dir befreundet sein."+answerbutton )
      end
  	end

  public
    def launch_action!()
      if self.action=="alliance_invite"
        self.sender.alliance.add_user(recipient)
        self.sender.system_notify("Allianzeinladung",self.recipient.username+" ist nun Teil deiner Allianz!","Tolle Wurst.")
        self.destroy
      elsif self.action=="friendship_invite"
        self.sender.make_friendship!(self.recipient)
        self.sender.system_notify("Freundschaftsanfrage",self.recipient.username+" hat deine Anfrage angenommen!","Tolle Wurst.")
        self.destroy
      end
    end
    
end
