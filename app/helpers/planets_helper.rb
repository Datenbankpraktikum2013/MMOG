module PlanetsHelper

  @@marker = []
  @@marker_pos = 0

  def self.search_startplanet()
    if @@marker.nil? || @@marker.length < 8 then
      @@marker = Planet.where(special: 0, user_id: nil).limit(8)
    end
    return false if @@marker.empty?
    @@marker_pos = (@@marker_pos+1) % 8
    planet = @@marker[@@marker_pos]
    @@marker[@@marker_pos] = nil
    @@marker.compact!
    return planet
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

  def self.namegen()
    prename = [ "Adrastea", "Aether", "Amalthea", "Ananke", "Asopos", "Atlas", "Callisto", "Calypso", "Carme", "Cronus", "Dactyli", "Deimos", "Demeter", "Despina", "Dione", "Elara", " Enceladus", "Epimetheus", "Eros", "Galatea", "Ganymed", "Hemera", "Hestia", "Himalia", "Hyperion", "Iapetus", "Jupiter", "Mars", "Merkur", "Naiad", "Okeanos", "Pandora", "Phobos", "Prometheus", " Proteus", "Thetys", "Triton", "Uranus", "Venus", "Fleet"]
    letter = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    x = Random.rand(prename.length)
    prename[x] + "-" + letter[Random.rand(letter.length)] + letter[Random.rand(letter.length)].downcase
  end

  def fetch_research_data(user)
    return [0, 0] if user.nil? || user.planets.nil?
    max_level = 0
    data = [0,0]
    user.planets.each do |p|

      a = p.research_level if
      if b[0] < a
        b[0] = a
      end
      b[1] += 1
    end

  end


end