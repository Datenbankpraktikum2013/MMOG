#require "/app/models/planet"

class ResearchTechnology
  @queue = "research_technology"

  def self.perform(user, tech)
    puts "Loading job"
    t = Technology.find(tech)
    t.update_usertechnologies(user)
    puts "Update UserTechnologies"
  end

end