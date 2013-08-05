class Building < ActiveRecord::Base

  # belongs_to :buildingtype
  belongs_to :planet
  belongs_to :buildingtype



  def get_level()
    self.buildingtype.level
  end

=begin
  def getProduktion()
    self.Buildingtype.produktion
  end

  def getEnergieverbrauch()
    self.Buildingtype.energieverbrauch
  end

  def getName()
    self.Buildingtype.name
  end

=end

  def upgrade()
    # TODO Ueberpruefen, ob ein neuer Typ zugewiesen wird
    # self.buildingtype = Buildingtype.where(name: self.getName(), stufe: self.getStufe() + 1)
    next_buildingtype  = self.buildingtype.where(name: self.buildingtype.name, level: self.buildingtype.level + 1)
    if next_buildingtype.nil? then
      return false
    else
      anforderungen = next_buildingtype.first.requirements
    end
    nachbarn = self.planet.buildings

    a = true
    anforderungen.each do |t|
      nachbarn.each do |s|

        if t.name = s.name
          if t.level > s.get_level
            a = false
          end
        end
      end
    end

    if a

      self.buildingtype = next_buildingtype

    end
  end

end
