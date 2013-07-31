module GalaxiesHelper

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
      #s.gal = Sunsystem.create(name: name, y: y, )
    end
  end

end
