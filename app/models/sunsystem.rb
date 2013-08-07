class Sunsystem < ActiveRecord::Base

  has_many :planets
  has_and_belongs_to_many :users
  belongs_to :galaxy

  @@sun_factor = GameSettings.get("WORLD_DISTANCE_FACTOR").to_i

  def getDistance(other)
    if(other.is_a? Sunsystem) then

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
        #dist2 = ((self.y + other.y)**3)/((self.y - other.y)**2 + 1)
        dist2 = self.y + other.y
      end
      dist1 + @@sun_factor * dist2

    else
      -1
    end
  end

  def mention()
    self.galaxy.mention()
  end

  def seen_by(user)
    self.users << user if !user.nil? && !self.is_visible_by?(user)
  end

  def is_visible_by?(user)
    return false if user.nil?
    return user.visible_sunsystems.include?(self)
  end

end
