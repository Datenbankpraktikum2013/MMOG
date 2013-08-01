module GalaxiesHelper

  SPECIALISATION_COUNT = 5
  MIN_SIZE = 123456789
  MAX_SIZE = 987654321

  # Generate a full Galaxy at x, y, if not yet existing
  # TODO Ausschreiben der Funktion, so nicht moeglich...
  def self.generateAt(x, y)
    x = Galaxy.calcX(x, y)
    unless x < 0 || Galaxy.where(x: x).exists? then
      name = "New Galaxy " + x.to_s
      g = Galaxy.create(x: x, name: name)
      pos = [1, 2, 3, 4, 5, 6, 7, 8]
      pos.shuffle!

      i = Random.rand(4) + 4
      i.times do |y|
        name = "New Sunsystem " + y.to_s
        s = Sunsystem.new(name: name, y: pos[y])
        s.galaxy_id = g.id
        s.save
        pos2 = [1, 2, 3, 4, 5, 6, 7, 8]
        pos2.shuffle!

        j = Random.rand(4)+4
        if j > 6 then
          k = 2
        else
          k = 1
        end

        k.times do |k2|
          name = "New Startplanet " + k2.to_s
          # TODO Weitere Startattribute festlegen!
          p = Planet.new(pla_name: name, pla_z: pos2[k2], pla_specialty: false, pla_sunsystem_id: s_id)
        end

        j -= k
        j.times do |z|
          name = "New Planet " + (z + k).to_s
          # TODO Attribute nicht vergessen (Nullwerte vermeiden!)
          p = Planet.new(pla_name: name, pla_z: pos2[z + k], pla_specialty: true, pla_sunsystem_id: s_id)
        end
      end
    end
  end

  def self.generateNear(x, y)
    k = 0
    3.times do |m|
      3.times do |n|
        k += 1
        generateAt(x - 1 + m, y - 1 + n)
        puts(k.to_s + " galaxies with " + Planet.all.count.to_s + " planets in " + Sunsystem.all.count.to_s + " sunsystems created (" + (11*k).to_s + "%).")
      end
    end
  end

  def self.generateRegion(from_x, from_y, to_x, to_y)
    for act_x in from_x..to_x
      for act_y in from_y..to_y
        generateAt(act_x, act_y)
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

  def self.isVisible(nr)
    Array.new([4,6,8,9,10,12,13,14,15,18,19,20,25,26,32]).include?(nr)
  end

  def self.isMeins(nr)
    Array.new([8,9,13,14,19,20,25,32]).include?(nr)
  end

end
