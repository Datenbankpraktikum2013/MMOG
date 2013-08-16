class Buildingtype < ActiveRecord::Base

  has_many :buildings
  has_many :buildingtype_requires
  has_many :requirements, through: :buildingtype_requires
  has_many :inverse_buildingtype_requires, :class_name => "BuildingtypeRequire", :foreign_key => "requirement_id"
  has_many :inverse_buildingtypes, :through => :inverse_buildingtype_requires, :source => :buildingtype
  has_and_belongs_to_many :ships
  has_and_belongs_to_many :spyreports
  has_and_belongs_to_many :battlereports

  def self.init()

    Buildingtype.create({:name =>'Headquarter', :level=> 1, :production=> 1, :energyusage=> 20, :build_time=>0, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Headquarter', :level=> 2, :production=> 2, :energyusage=> 50, :build_time=>300, :build_cost_ore =>200, :build_cost_crystal =>0, :build_cost_money =>1024, :build_cost_population =>50})
    Buildingtype.create({:name =>'Headquarter', :level=> 3, :production=> 3, :energyusage=> 100, :build_time=>2500, :build_cost_ore =>500, :build_cost_crystal =>0, :build_cost_money =>7000, :build_cost_population =>100})
    Buildingtype.create({:name =>'Headquarter', :level=> 4, :production=> 4, :energyusage=> 250, :build_time=>10000, :build_cost_ore =>2500, :build_cost_crystal =>0, :build_cost_money =>25000, :build_cost_population =>200})
    Buildingtype.create({:name =>'Headquarter', :level=> 5, :production=> 5, :energyusage=> 500, :build_time=>50000, :build_cost_ore =>10000, :build_cost_crystal =>2, :build_cost_money =>78000, :build_cost_population =>500})

    Buildingtype.create({:name =>'Oremine', :level=> 1, :production=> 1, :energyusage=>0, :build_time=>0, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Oremine', :level=> 2, :production=> 3, :energyusage=>5, :build_time=>60, :build_cost_ore =>5, :build_cost_crystal =>0, :build_cost_money =>100, :build_cost_population =>40})
    Buildingtype.create({:name =>'Oremine', :level=> 3, :production=> 7, :energyusage=>10, :build_time=>100, :build_cost_ore =>10, :build_cost_crystal =>0, :build_cost_money =>250, :build_cost_population =>60})
    Buildingtype.create({:name =>'Oremine', :level=> 4, :production=> 15, :energyusage=>20, :build_time=>150, :build_cost_ore =>20, :build_cost_crystal =>0, :build_cost_money =>600, :build_cost_population =>80})
    Buildingtype.create({:name =>'Oremine', :level=> 5, :production=> 30, :energyusage=>40, :build_time=>300, :build_cost_ore =>40, :build_cost_crystal =>0, :build_cost_money =>1024, :build_cost_population =>100})
    Buildingtype.create({:name =>'Oremine', :level=> 6, :production=> 50, :energyusage=>70, :build_time=>450, :build_cost_ore =>70, :build_cost_crystal =>0, :build_cost_money =>1500, :build_cost_population =>120})
    Buildingtype.create({:name =>'Oremine', :level=> 7, :production=> 75, :energyusage=>110, :build_time=>600, :build_cost_ore =>100, :build_cost_crystal =>0, :build_cost_money =>2500, :build_cost_population =>150})
    Buildingtype.create({:name =>'Oremine', :level=> 8, :production=> 110, :energyusage=>160, :build_time=>900, :build_cost_ore =>150, :build_cost_crystal =>0, :build_cost_money =>4000, :build_cost_population =>170})
    Buildingtype.create({:name =>'Oremine', :level=> 9, :production=> 150, :energyusage=>220, :build_time=>1500, :build_cost_ore =>220, :build_cost_crystal =>0, :build_cost_money =>6000, :build_cost_population =>200})
    Buildingtype.create({:name =>'Oremine', :level=> 10, :production=> 200, :energyusage=>290, :build_time=>3600, :build_cost_ore =>300, :build_cost_crystal =>0, :build_cost_money =>9000, :build_cost_population =>220})
    Buildingtype.create({:name =>'Oremine', :level=> 11, :production=> 275, :energyusage=>370, :build_time=>5400, :build_cost_ore =>400, :build_cost_crystal =>0, :build_cost_money =>13000, :build_cost_population =>250})
    Buildingtype.create({:name =>'Oremine', :level=> 12, :production=> 375, :energyusage=>460, :build_time=>8000, :build_cost_ore =>520, :build_cost_crystal =>0, :build_cost_money =>18000, :build_cost_population =>300})
    Buildingtype.create({:name =>'Oremine', :level=> 13, :production=> 500, :energyusage=>560, :build_time=>11000, :build_cost_ore =>650, :build_cost_crystal =>0, :build_cost_money =>24000, :build_cost_population =>350})
    Buildingtype.create({:name =>'Oremine', :level=> 14, :production=> 650, :energyusage=>670, :build_time=>15000, :build_cost_ore =>1000, :build_cost_crystal =>0, :build_cost_money =>31000, :build_cost_population =>400})
    Buildingtype.create({:name =>'Oremine', :level=> 15, :production=> 850, :energyusage=>790, :build_time=>20000, :build_cost_ore =>1500, :build_cost_crystal =>1, :build_cost_money =>39000, :build_cost_population =>450})
    Buildingtype.create({:name =>'Oremine', :level=> 16, :production=> 1100, :energyusage=>920, :build_time=>27000, :build_cost_ore =>3000, :build_cost_crystal =>2, :build_cost_money =>47000, :build_cost_population =>500})
    Buildingtype.create({:name =>'Oremine', :level=> 17, :production=> 1400, :energyusage=>1060, :build_time=>35000, :build_cost_ore =>5000, :build_cost_crystal =>4, :build_cost_money =>57000, :build_cost_population =>550})
    Buildingtype.create({:name =>'Oremine', :level=> 18, :production=> 1750, :energyusage=>1210, :build_time=>45000, :build_cost_ore =>8000, :build_cost_crystal =>6, :build_cost_money =>78000, :build_cost_population =>600})
    Buildingtype.create({:name =>'Oremine', :level=> 19, :production=> 2200, :energyusage=>1370, :build_time=>60000, :build_cost_ore =>12000, :build_cost_crystal =>8, :build_cost_money =>90000, :build_cost_population =>650})
    Buildingtype.create({:name =>'Oremine', :level=> 20, :production=> 2800, :energyusage=>1550, :build_time=>80000, :build_cost_ore =>17000, :build_cost_crystal =>10, :build_cost_money =>120000, :build_cost_population =>700})

    Buildingtype.create({:name =>'Powerplant', :level => 1, :production=> 200, :energyusage=>0, :build_time=>0, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'Powerplant', :level => 2, :production=> 750, :energyusage=>0, :build_time=>300, :build_cost_ore =>200, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>50})
    Buildingtype.create({:name =>'Powerplant', :level => 3, :production=> 1600, :energyusage=>0, :build_time=>2500, :build_cost_ore =>500, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>100})
    Buildingtype.create({:name =>'Powerplant', :level => 4, :production=> 3500, :energyusage=>0, :build_time=>10000, :build_cost_ore =>2500, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>200})
    Buildingtype.create({:name =>'Powerplant', :level => 5, :production=> 5000, :energyusage=>0, :build_time=>50000, :build_cost_ore =>10000, :build_cost_crystal =>1, :build_cost_money =>0, :build_cost_population =>500})

    Buildingtype.create({:name =>'ResearchLab', :level => 1, :production=> 0, :energyusage=> 75, :build_time=>5, :build_cost_ore =>200, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>100})
    Buildingtype.create({:name =>'ResearchLab', :level => 2, :production=> 0, :energyusage=> 200, :build_time=>3000, :build_cost_ore =>500, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>200})
    Buildingtype.create({:name =>'ResearchLab', :level => 3, :production=> 0, :energyusage=> 400, :build_time=>12500, :build_cost_ore =>1000, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>300})
    Buildingtype.create({:name =>'ResearchLab', :level => 4, :production=> 0, :energyusage=> 700, :build_time=>70000, :build_cost_ore =>10000, :build_cost_crystal =>2, :build_cost_money =>0, :build_cost_population =>500})

    Buildingtype.create({:name =>'City', :level=> 1, :production=> 5, :energyusage=> 20, :build_time=>0, :build_cost_ore =>0, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>0})
    Buildingtype.create({:name =>'City', :level=> 2, :production=> 10, :energyusage=> 50, :build_time=>300, :build_cost_ore =>100, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>50})
    Buildingtype.create({:name =>'City', :level=> 3, :production=> 20, :energyusage=> 100, :build_time=>2500, :build_cost_ore =>500, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>100})
    Buildingtype.create({:name =>'City', :level=> 4, :production=> 40, :energyusage=> 250, :build_time=>10000, :build_cost_ore =>2500, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>200})
    Buildingtype.create({:name =>'City', :level=> 5, :production=> 75, :energyusage=> 500, :build_time=>50000, :build_cost_ore =>10000, :build_cost_crystal =>1, :build_cost_money =>0, :build_cost_population =>500})

    Buildingtype.create({:name =>'Depot', :level=> 1, :production=> 200, :energyusage=> 5, :build_time=>250, :build_cost_ore =>50, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>50})
    Buildingtype.create({:name =>'Depot', :level=> 2, :production=> 1000, :energyusage=> 20, :build_time=>2000, :build_cost_ore =>200, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>100})
    Buildingtype.create({:name =>'Depot', :level=> 3, :production=> 1500, :energyusage=> 40, :build_time=>3600, :build_cost_ore =>500, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>200})
    Buildingtype.create({:name =>'Depot', :level=> 4, :production=> 2000, :energyusage=> 75, :build_time=>8000, :build_cost_ore =>2500, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>300})
    Buildingtype.create({:name =>'Depot', :level=> 5, :production=> 6000, :energyusage=> 120, :build_time=>40000, :build_cost_ore =>10000, :build_cost_crystal =>1, :build_cost_money =>0, :build_cost_population =>500})

    Buildingtype.create({:name =>'Crystalmine', :level=> 1, :production=> 1, :energyusage=> 100, :build_time=>1000, :build_cost_ore =>200, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>100})
    Buildingtype.create({:name =>'Crystalmine', :level=> 2, :production=> 2, :energyusage=> 200, :build_time=>5000, :build_cost_ore =>500, :build_cost_crystal =>3, :build_cost_money =>0, :build_cost_population =>200})
    Buildingtype.create({:name =>'Crystalmine', :level=> 3, :production=> 3, :energyusage=> 400, :build_time=>12500, :build_cost_ore =>1000, :build_cost_crystal =>5, :build_cost_money =>0, :build_cost_population =>300})
    Buildingtype.create({:name =>'Crystalmine', :level=> 4, :production=> 4, :energyusage=> 700, :build_time=>40000, :build_cost_ore =>10000, :build_cost_crystal =>7, :build_cost_money =>0, :build_cost_population =>400})
    Buildingtype.create({:name =>'Crystalmine', :level=> 5, :production=> 5, :energyusage=> 1000, :build_time=>75000, :build_cost_ore =>50000, :build_cost_crystal =>10, :build_cost_money =>0, :build_cost_population =>500})

    Buildingtype.create({:name =>'Starport', :level=> 1, :production=> 0, :energyusage=> 50, :build_time=>300, :build_cost_ore =>200, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>50})
    Buildingtype.create({:name =>'Starport', :level=> 2, :production=> 0, :energyusage=> 120, :build_time=>3000, :build_cost_ore =>500, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>100})
    Buildingtype.create({:name =>'Starport', :level=> 3, :production=> 0, :energyusage=> 200, :build_time=>15000, :build_cost_ore =>1000, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>200})
    Buildingtype.create({:name =>'Starport', :level=> 4, :production=> 0, :energyusage=> 350, :build_time=>32000, :build_cost_ore =>5000, :build_cost_crystal =>0, :build_cost_money =>0, :build_cost_population =>300})
    Buildingtype.create({:name =>'Starport', :level=> 5, :production=> 0, :energyusage=> 500, :build_time=>60000, :build_cost_ore =>7500, :build_cost_crystal =>2, :build_cost_money =>0, :build_cost_population =>500})


    BuildingtypeRequire.init()

  end


end
