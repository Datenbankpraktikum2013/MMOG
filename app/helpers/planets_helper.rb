module PlanetsHelper

  def self.search_startplanet()



  end

  def self.claim_startplanet_for(user)
    return false if user.is_a?User || user.nil?
    p = search_startplanet
    if !p.is_a?Planet || p.nil? || !p.user.nil?
      p.claim(user)
    else
      return false
    end
  end

end
