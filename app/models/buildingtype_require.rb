class BuildingtypeRequire < ActiveRecord::Base
  belongs_to :buildingtype
  belongs_to :requirement, :class_name => "Buildingtype"

  def init_building_requirements

    t = ["Oremine", "ResearchLab", "Powerplant", "Headquarter", "Starport", "City", "Depot", "Crystalmine"]
    ore = [[1,1,nil, 1, nil, 1, 1, nil],
           [2,1,1,2,nil,2,2,nil],
           [3,2,2,2,1,3,4,nil],
           [4,4,4,3,2,4,5,nil]
    ]

    res = [[2,1,2,1,nil,1,1],
           [3,2,3,2,nil,2,2],
           [3,3,4,4,1,4,3]
    ]

    pow = [[2,1,1,1,nil,1,1,nil],
           [2,2,2,2,nil,2,2,nil],
           [3,2,3,3,nil,3,2,nil],
           [4,4,4,4,1,4,4,nil]
    ]

    head = [[1,nil,1,1,nil,1,1,nil]  ,
            [2,1,2,2,nil,2,2,nil],
            [3,2,3,3,nil,3,2,nil] ,
            [4,3,4,4,1,4,3,nil]
    ]

    star = [[3,3,3,3,nil,3,3,3],
            [3,3,3,3,1,3,3,3],
            [3,3,3,3,2,3,3,3],
            [3,3,3,3,3,3,3,3],
            [3,3,3,3,4,3,3,3]
    ]

    city = [[1,1,2,2,nil,1,1,nil],
            [2,2,3,2,nil,2,2,nil],
            [2,3,4,3,nil,3,2,nil],
            [3,4,4,3,1,4,3,nil]
    ]

    depot = [[1,1,1,1,nil,1,1,nil],
             [2,2,2,2,nil,1,2,nil],
             [3,3,3,2,nil,1,3,nil],
             [3,4,4,3,nil,2,4,nil]
    ]

    crys = [[nil,1,1,1,nil,1,1,nil],
            [1,2,2,1,nil,2,2,1],
            [1,2,2,2,nil,3,3,2],
            [2,3,3,2,nil,4,4,3],
            [2,3,3,2,nil,4,4,4]
    ]

    reqs = [ore, res, pow, head, star, city, depot, crys]





    inserts = []

    from_elem = Buildingtype.where(name: t[0], level: 2)
    to_elem = Buildingtype.where(name: t[a], level: a.level)
    unless from_elem.nil? || to_elem.nil?
      from = from_elem.first
      to = to_elem.first
      inserts.push({:buildingtype_id => from.id, :requirement_id => to.id})
    end

      BuildingtypeRequire.create()



    inserst.push({:buildingtype_id => buildingtype.id, :requirement_id => a.id})



  end

end
