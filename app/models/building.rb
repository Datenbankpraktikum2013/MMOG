class Building < ActiveRecord::Base

  # belongs_to :buildingtype
  belongs_to :planet
  belongs_to :buildingtype
  @cache_verifies_upgrade


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
    if next_buildingtype.nil? || !self.verifies_upgrade_requirements? then
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

  def verifies_upgrade_requirements?()
    if @cache_verifies_upgrade.nil? then
      builds = self.planet.buildings_to_hash
      btype = self.buildingtype
      btypenext = Buildingtype.where(name: btype.name, level: btype.level + 1)
      return false if btypenext.nil? || btypenext.empty?
      btype = btypenext.first()
      required = btype.requirements
      return true if required.nil? || required.empty?
      allow = true

      required.each do |req|
        if req.level > builds[req.name.to_sym] then
          allow = false
        end
      end
      @cache_verifies_upgrade = allow
    end
    return @cache_verifies_upgrade

  end

end
