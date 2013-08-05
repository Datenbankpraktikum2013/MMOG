#require "/app/models/planet"

class ResearchTechnology
  @queue = "research_technology"

  def self.perform(user, tech)
    puts "Loading job"

    t = Technology.find(tech)
    puts "Update UserTechnologies"
    t.update_uservalues(user)

  end

end