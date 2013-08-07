#require "/app/models/planet"

class ResearchTechnology
  @queue = "research_technology"

  def self.perform(user, tech)
    puts "Loading job"
    puts "Update UserTechnologies"
    Technology.find(tech).update_uservalues(User.find(user))

  end

end