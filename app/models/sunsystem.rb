class Sunsystem < ActiveRecord::Base

  has_many :planets
  belongs_to :galaxy

  def getDistance(other)
    if(other is_a? Sunsystem) then

      dist1 = self.galaxy.getDistance(other.galaxy)
      if( dist1 < 0 ) then
        return -1
      end

      if(dist1 == 0) then

        if self.y < other.y then
          dist2 = other.y - self.y
        else
          dist2 = self.y - other.y
        end
      else
        dist2 = ((self.y + other.y)^3)/((self.y - other.y)^2 + 1)
      end
      dist1 + 10 * dist2

    else
      -1
    end
  end


end
