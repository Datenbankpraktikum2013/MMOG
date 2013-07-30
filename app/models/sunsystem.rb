class Sunsystem < ActiveRecord::Base

      def getDistance(other)
      if(other is_a? Sunsystem)

        dist1 = self.galaxy.getDistance(other.galaxy)

        if(dist1 == 0) then

          if self.id < other.id then
            dist2 = other.id - self.id
          else
            dist2 = self.id - other.id
          end

        else

          dist2 = ((self.id + other.id)^3)/((self.id - other.id)^2 + 1)

        end

        return dist1 + 10 * dist2

      else
        -1
      end



end
