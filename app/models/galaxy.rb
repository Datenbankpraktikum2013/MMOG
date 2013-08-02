class Galaxy < ActiveRecord::Base

  has_many :sunsystems

  def self.calcX(x, y)
    if x.integer? && y.integer? then
      x = x % 5
      y = y % 5
      #x = x % $game_settings[:world_length]
      #y = y % $game_settings[:world_length]
      (x + y) * (x + y + 1) / 2 + y + 1
    else
      -1
    end
  end

  def getCoords()
    if self.x > 0 then
      i = self.x - 1
      j = (Math.sqrt(0.25 + 2 * i) - 0.5).floor
      [j - (i - j*(j+1)/2), i - j*(j+1)/2]
    else
      [-1, -1]
    end
  end

  def getDistance(other)
    $game_settings = Hash.new()
    $game_settings[:world_length] = 5

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
      dist.append(Math.sqrt(x**2 + y**2))

      # Indirekt "V" / Universum vertikal umklappen
      y2 = $game_settings[:world_length] - y
      dist.append(Math.sqrt(x**2 + y2**2))

      # Indirekt "VH" / Universum vertikal und horizontal umklappen
      x = $game_settings[:world_length] - x
      dist.append(Math.sqrt(x**2 + y2**2))

      # Indirekt "H" / Universum horizontal umklappen
      dist.append(Math.sqrt(x**2 + y**2))

      dist.sort().first() * 100

    else
      -1
    end
  end

  def mention()
    pos = self.getCoords()
    GalaxiesHelper.generateNear(pos[0], pos[1])
  end
end
