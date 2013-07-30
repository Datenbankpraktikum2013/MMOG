class Galaxy < ActiveRecord::Base

  WORLD_LENGTH = 2

  has_many :sunsystems

  def self.calcID(x, y)
    if x.integer? && y.integer? then
      (x + y) * (x + y + 1) / 2 + y + 1
    else
      -1
    end
  end

  def getCoords()
    if self.id > 0 then
      i = self.id - 1
      j1 = Math.sqrt(0.25 + 2 * i - 0.5).floor
      j2 = j1 * (j1 + 1) / 2
      [j1 - j2, i - j1]
    else
      [-1, -1]
    end
  end

  def getDistance(other)
    if other.is_a?Galaxy then
      dist = Array.new()
      pos1 = self.getCoords()
      pos2 = other.getCoords()

      # Position ist fehlerhaft
      if pos1[0] < 0 || pos1[1] < 0 || pos2[0] < 0 || pos2[1] < 0 then
        return -1
      end

      # Direkter Weg / Universum nicht umklappen
      if pos1[0] < pos2[0]
        x = pos2[0] - pos1[0]
      else
        x = pos1[0] - pos2[0]
      end
      if pos1[1] < pos2[1]
        y = pos2[1] - pos1[1]
      else
        y = pos1[1] - pos2[1]
      end
      dist.append(Math.sqrt(x^2 + y^2))

      # Indirekt "V" / Universum vertikal umklappen
      y2 = WORLD_LENGTH - y
      dist.append(Math.sqrt(x^2 + y2^2))

      # Indirekt "VH" / Universum vertikal und horizontal umklappen
      x = WORLD_LENGTH - x
      dist.append(Math.sqrt(x^2 + y2^2))

      # Indirekt "H" / Universum horizontal umklappen
      dist.append(Math.sqrt(x^2 + y^2))

      dist.sort().first() * 100

    else
      -1
    end
  end

end
