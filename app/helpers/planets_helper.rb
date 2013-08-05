module PlanetsHelper

  def self.search_startplanet()
    my_start_planet = Planet.where(special: 0, user_id: nil).first
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




end
