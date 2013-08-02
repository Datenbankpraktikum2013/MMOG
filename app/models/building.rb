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
  end

end
