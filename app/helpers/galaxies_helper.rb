module GalaxiesHelper

  SPECIALISATION_COUNT = 5
  MIN_SIZE = 123456789
  MAX_SIZE = 987654321

  # Generate a full Galaxy at x, y, if not yet existing
  # TODO Ausschreiben der Funktion, so nicht moeglich...
  def generateAt(x, y)
    x = Galaxy.calcX(x, y)
    if x < 0 || Galaxy.where(id: x).exists? then
      return
    end
    name = "New Galaxy " + x
    g = Galaxy.create(x: Galaxy.calcID(x, y), name: name)
    pos = [1, 2, 3, 4, 5, 6, 7, 8]
    pos.shuffle()
    i = Random.rand(4)+4
    i.times do |y|
      name = "New Sunsystem " + y
      s = Sunsystem.new(name: name, y: pos[y])
      s.galaxy_id = g.id
      s.save
      pos2 = [1, 2, 3, 4, 5, 6, 7, 8]
      pos2.shuffle()
      name = "New Startplanet"

      j = Random.rand(4)+4
      if j
      .times
      # TODO Weitere Startattribute festlegen!
      p = Planet.new(name: name, z: pos[0], special: spec, size: (MIN_SIZE+MAX_SIZE)/2)
      p.sunsystem_id = s.id
      p.save



      if i > 6 then

        j -= 1
      else

      end

      j.times do |z|
        name = "New Planet " + z + 1
        spec = Random.rand(SPECIALISATION_COUNT) + 1
        size = Random.rand(MAXSIZ - MIN_SIZE) + MIN_SIZE

        # TODO Attribute nicht vergessen (Nullwerte vermeiden!)
        p = Planet.new(name: name, z: pos[z + 1], special: spec, size: size)
        p.sunsystem_id = s.id
        p.save
      end
    end
  end

end
