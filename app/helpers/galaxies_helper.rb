module GalaxiesHelper

  SPECIALISATION_COUNT = 5
  MIN_SIZE = 123456789
  MAX_SIZE = 987654321

  # Generate a full Galaxy at x, y, if not yet existing
  # TODO Ausschreiben der Funktion, so nicht moeglich...
  def self.generateAt(x, y)
    x = Galaxy.calcX(x, y)
    unless x < 0 || Galaxy.where(x: x).exists? then
      ActiveRecord::Base.transaction do
        name = namegen()
      g = Galaxy.create(x: x, name: name)
      pos = [1, 2, 3, 4, 5, 6, 7, 8]
      pos.shuffle!

      i = Random.rand(5) + 4
      i.times do |y|
        name = SunsystemsHelper.namegen()
        s = Sunsystem.new(name: name, y: pos[y])
        s.galaxy = g
        s.save
        pos2 = [1, 2, 3, 4, 5, 6, 7, 8]
        pos2.shuffle!

        j = Random.rand(5)+4
        if j > 6 then
          k = 2
        else
          k = 1
        end

        k.times do |k2|
          p = Planet.create(z: pos2[k2], special: 0, sunsystem_id: s.id)
        end

        j = j - k
        j.times do |z|
          p = Planet.create(z: pos2[z + k], special: 1, sunsystem_id: s.id)
          end
        end
      end
    end
  end

  def self.generateNear(x, y)
    3.times do |m|
      3.times do |n|
        generateAt(x - 1 + m, y - 1 + n)
      end
    end
  end

  def self.generateRegion(from_x, from_y, to_x, to_y)
    schritt = 100 / ((to_y - from_y + 1) * (to_x - from_x + 1))
    proz = 0
    for act_x in from_x..to_x
      for act_y in from_y..to_y
        generateAt(act_x, act_y)
        puts "Generating world region... (" + (proz+=schritt).to_s + "%)"
      end
    end
  end

  def self.getImageFilename(nr, size)
    filename = "images/galaxies/"
    selector = nr % 24
    if( selector > 17 ) then
      filename += "l/"
    elsif (selector > 11) then
      filename += "d/"
    elsif( selector > 5) then
      filename += "r/"
    else
      filename += "u/"
    end
    filename = filename + size.to_s + "_" + (selector % 6 + 1).to_s + ".png"
  end

  def self.namegen()
     prename = ["Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota", "Kappa", "Lambda", "Orion", "Centauri", "Andromeda", "Omikron", "M 60", "M 73", "Sigma", "M 42", "Ypsilon", "NGC 95", "Rumpelstilz", "Troutt", "Omega"]
     letter = ["A","B","C","D","E","F","G","H"]
     x = Random.rand(prename.length)
    prename[x] + "-" + letter[Random.rand(letter.length)] + letter[Random.rand(letter.length)].downcase

  end

  def self.discover_new_planet_at(x,y)
    return false unless x.is_a?(Integer) && y.is_a?(Integer)
    xxx = Galaxy.calcX(x,y)
    g = Galaxy.find(xxx)
    return false if g.nil?
    plts = []
    suns = g.sunsystems
    suns.each do |sun|
      plts.concat sun.planets
    end
    return plts.shuffle![0]
  end

end