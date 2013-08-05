#require "/app/models/planet"

class ResearchTechnology
  @queue = "research technology"

  def self.perform(user, tech)
    t = Technology.find(tech)
    t.upgrade_technology(user)
  end

end