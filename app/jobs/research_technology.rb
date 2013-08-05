#require "/app/models/planet"

class ResearchTechnology
  @queue = "research_technology"

  def self.perform(user, tech)
    t = Technology.find(tech)
    t.update_usersettings(user)
  end

end