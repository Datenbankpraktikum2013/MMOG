class Galaxy < ActiveRecord::Base

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
      array(j1 - j2, i - j1)
    else
      array(-1, -1)
    end
  end

  def getDistance(other)
    if other.is_a?Galaxy then
      pos1 = self.getCoords()
      pos2 = other.getCoords()
      # TODO     RECHNUNG

    else
      -1
    end
  end

end
