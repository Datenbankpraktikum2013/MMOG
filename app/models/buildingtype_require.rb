class BuildingtypeRequire < ActiveRecord::Base
  belongs_to :buildingtype
  belongs_to :requirement, :class_name => "Buildingtype"

  def self.init_building_requirements()
    t = ["Oremine", "ResearchLab", "Powerplant", "Headquarter", "Starport", "City", "Depot", "Crystalmine"]
    ore = [[nil, nil, nil, nil, nil, nil, nil, nil],
           [1,1,nil, 1, nil, 1, 1, nil],
           [2,1,1,2,nil,2,2,nil],
           [3,2,2,2,1,3,4,nil],
           [4,4,4,3,2,4,5,nil]
    ]

    res = [[nil, nil, nil, nil, nil, nil, nil, nil],
           [2,1,2,1,nil,1,1],
           [3,2,3,2,nil,2,2],
           [3,3,4,4,1,4,3],
           [nil,5,nil,nil,nil,nil,nil,nil]
    ]

    pow = [[nil, nil, nil, nil, nil, nil, nil, nil],
           [2,1,1,1,nil,1,1,nil],
           [2,2,2,2,nil,2,2,nil],
           [3,2,3,3,nil,3,2,nil],
           [4,4,4,4,1,4,4,nil]
    ]

    head = [[nil, nil, nil, nil, nil, nil, nil, nil],
            [1,nil,1,1,nil,1,1,nil]  ,
            [2,1,2,2,nil,2,2,nil],
            [3,2,3,3,nil,3,2,nil] ,
            [4,3,4,4,1,4,3,nil]
    ]

    star = [[1,1,1,1,nil,1,1,1],
            [2,2,2,2,1,2,2,2],
            [3,3,3,3,2,3,3,3],
            [3,3,3,3,3,3,3,3],
            [3,3,3,3,4,3,3,3]
    ]

    city = [[nil, nil, nil, nil, nil, nil, nil, nil],
            [1,1,2,2,nil,1,1,nil],
            [2,2,3,2,nil,2,2,nil],
            [2,3,4,3,nil,3,2,nil],
            [3,4,4,3,1,4,3,nil]
    ]

    depot = [[nil, nil, nil, nil, nil, nil, nil, nil],
             [1,1,1,1,nil,1,1,nil],
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

    #for r in 0..(regs.length-1)
    reqs.each do |r|
      #for s in 0..(reqs[r].length-1)
      r.each do  |s|
        #s.each do |p|
        for p in 0..7
          unless p.nil? then
          level = (r.index(s)) + 1
          name = t[reqs.index(r)]
          levelto = s[p]
          nameto =  t[p]


          from_elem = Buildingtype.where(name: name, level: level)
          to_elem = Buildingtype.where(name: nameto, level: levelto)
          unless from_elem.nil? || from_elem.empty? || to_elem.nil? || to_elem.empty? then
            from = from_elem.first
            to = to_elem.first
            if BuildingtypeRequire.where(:buildingtype_id => from.id, :requirement_id => to.id).empty?
              inserts.push({:buildingtype_id => from.id, :requirement_id => to.id})
            end
          end
         end
        end
      end
    end

    self.transaction do
      BuildingtypeRequire.create(inserts)
    end

  end

end
