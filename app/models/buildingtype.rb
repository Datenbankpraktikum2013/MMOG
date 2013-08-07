class Buildingtype < ActiveRecord::Base

  has_many :buildings
  has_many :buildingtype_requires
  has_many :requirements, through: :buildingtype_requires
  has_many :inverse_buildingtype_requires, :class_name => "BuildingtypeRequire", :foreign_key => "requirement_id"
  has_many :inverse_buildingtypes, :through => :inverse_buildingtype_requires, :source => :buildingtype
  has_and_belongs_to_many :ships
  has_and_belongs_to_many :spyreports

  def self.init()

    Buildingtype.create({:name =>'Headquarter', :level=> 1, :production=> 1, :energyusage=> 0, :build_time=>0, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Headquarter', :level=> 2, :production=> 1, :energyusage=> 0, :build_time=>30, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Headquarter', :level=> 3, :production=> 1, :energyusage=> 0, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Headquarter', :level=> 4, :production=> 1, :energyusage=> 0, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Headquarter', :level=> 5, :production=> 1, :energyusage=> 0, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})

    Buildingtype.create({:name =>'Oremine', :level=> 1, :production=> 10, :energyusage=>0, :build_time=>0, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Oremine', :level=> 2, :production=> 20, :energyusage=>5, :build_time=>50, :build_cost_ore =>50, :build_cost_crystal =>0, :build_cost_money =>7000, :build_cost_population =>50})
    Buildingtype.create({:name =>'Oremine', :level=> 3, :production=> 30, :energyusage=>10, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Oremine', :level=> 4, :production=> 40, :energyusage=>15, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Oremine', :level=> 5, :production=> 50, :energyusage=>20, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})

    Buildingtype.create({:name =>'Powerplant', :level => 1, :production=> 10, :energyusage=>0, :build_time=>0, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Powerplant', :level => 2, :production=> 20, :energyusage=>0, :build_time=>120, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Powerplant', :level => 3, :production=> 30, :energyusage=>0, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Powerplant', :level => 4, :production=> 40, :energyusage=>0, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Powerplant', :level => 5, :production=> 50, :energyusage=>0, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})

    Buildingtype.create({:name =>'ResearchLab', :level => 1, :production=> 0, :energyusage=> 30, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'ResearchLab', :level => 2, :production=> 0, :energyusage=> 30, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'ResearchLab', :level => 3, :production=> 0, :energyusage=> 30, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'ResearchLab', :level => 4, :production=> 0, :energyusage=> 30, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})

    Buildingtype.create({:name =>'City', :level=> 1, :production=> 100, :energyusage=> 20, :build_time=>0, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'City', :level=> 2, :production=> 200, :energyusage=> 30, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'City', :level=> 3, :production=> 300, :energyusage=> 34, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'City', :level=> 4, :production=> 400, :energyusage=> 38, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'City', :level=> 5, :production=> 500, :energyusage=> 42, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})

    Buildingtype.create({:name =>'Depot', :level=> 1, :production=> 200, :energyusage=> 5, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Depot', :level=> 2, :production=> 300, :energyusage=> 5, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Depot', :level=> 3, :production=> 400, :energyusage=> 5, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Depot', :level=> 4, :production=> 500, :energyusage=> 5, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Depot', :level=> 5, :production=> 600, :energyusage=> 5, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})

    Buildingtype.create({:name =>'Crystalmine', :level=> 1, :production=> 1, :energyusage=> 100, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Crystalmine', :level=> 2, :production=> 2, :energyusage=> 200, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Crystalmine', :level=> 3, :production=> 3, :energyusage=> 300, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Crystalmine', :level=> 4, :production=> 4, :energyusage=> 400, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Crystalmine', :level=> 5, :production=> 5, :energyusage=> 500, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})

    Buildingtype.create({:name =>'Starport', :level=> 1, :production=> 0, :energyusage=> 50, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Starport', :level=> 2, :production=> 0, :energyusage=> 65, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Starport', :level=> 3, :production=> 0, :energyusage=> 80, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Starport', :level=> 4, :production=> 0, :energyusage=> 90, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Starport', :level=> 5, :production=> 0, :energyusage=> 100, :build_time=>50, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})


    BuildingtypeRequire.init()

  end


end
