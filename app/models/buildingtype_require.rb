class BuildingtypeRequire < ActiveRecord::Base
  belongs_to :buildingtype
  belongs_to :requirement, :class_name => "Buildingtype"

  def self.init()
    t = ["Oremine", "ResearchLab", "Powerplant", "Headquarter", "Starport", "City", "Depot", "Crystalmine"]
    reqs = [
        #Oremine
        [[nil, nil, nil, nil, nil, nil, nil, nil],
         [1, nil, 1, 1, nil, 1, nil, nil],
         [2, nil, 1, 1, nil, 1, nil, nil],
         [3, nil, 1, 1, nil, 1, nil, nil],
         [4, nil, 1, 1, nil, 1, nil, nil],
         [5, 1, 1, 1, nil, 1, nil, nil],
         [6, 1, 1, 1, nil, 1, nil, nil],
         [7, 1, 2, 2, nil, 2, nil, nil],
         [8, 1, 2, 2, nil, 2, nil, nil],
         [9, 2, 2, 2, nil, 2, nil, nil],
         [10, 2, 2, 2, nil, 2, nil, nil],
         [11, 2, 3, 3, nil, 3, nil, nil],
         [12, 2, 3, 3, nil, 3, nil, nil],
         [13, 2, 4, 3, nil, 3, nil, nil],
         [14, 3, 4, 3, nil, 3, nil, nil],
         [15, 3, 4, 4, nil, 3, nil, nil],
         [16, 3, 4, 4, nil, 4, nil, nil],
         [17, 3, 4, 4, nil, 4, nil, nil],
         [18, 4, 4, 4, nil, 4, nil, nil],
         [19, 4, 5, 4, nil, 4, nil, nil],
        ],
        #ResearchLab
        [[3, nil, 1, 1, nil, 1, nil, nil],
         [5, 1, 2, 2, nil, nil, 1],
         [10, 2, 3, 2, nil, nil, 2],
         [15, 3, 4, 4, 1, nil, 3],
         [nil, 5, nil, nil, nil, nil, nil, nil], #Bedingt sich selbst => Falls verfuegbar, kann ResearchLab 5 nicht gebaut werden.
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
         [nil, 5, nil, nil, nil, nil, nil, nil],
        ],
        #Powerplant
        [[nil, nil, nil, nil, nil, nil, nil, nil],
         [3, nil, 1, 1, nil, 1, nil, nil],
         [5, 1, 2, 1, nil, 2, nil, nil],
         [8, 2, 3, 2, nil, 2, nil, nil],
         [12, 3, 4, 3, nil, 3, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
         [nil, nil, 6, nil, nil, nil, nil, nil],
        ],
        #Headquarter
        [[nil, nil, nil, nil, nil, nil, nil, nil],
         [3, nil, 1, 1, nil, 1, nil, nil],
         [5, 1, 2, 2, nil, 1, nil, nil],
         [8, 2, 2, 3, 1, 3, nil, nil],
         [12, 3, 3, 4, 2, 4, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
         [nil, nil, nil, 6, nil, nil, nil, nil],
        ],
        #Starport
        [[3, 1, 1, 1, nil, 1, nil, nil],
         [5, 2, 2, 2, 1, 2, nil, nil],
         [8, 2, 2, 2, 2, 2, nil, nil],
         [12, 3, 3, 3, 3, 3, nil, nil],
         [15, 3, 3, 4, 4, 4, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
         [nil, nil, nil, nil, 6, nil, nil, nil],
        ],
        #City
        [[nil, nil, nil, nil, nil, nil, nil, nil],
         [3, nil, 2, 1, nil, 1, nil, nil],
         [5, 1, 3, 2, nil, 2, nil, nil],
         [8, 2, 4, 3, nil, 3, nil, nil],
         [12, 3, 4, 3, 1, 4, nil,nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
         [nil, nil, nil, nil, nil, 6, nil, nil],
        ],
        #Depot
        [[1, nil, 1, 1, nil, 1, nil, nil],
         [3, 1, 1, 1, nil, 1, 1, nil],
         [5, 2, 2, 2, nil, 2, 2, nil],
         [8, 3, 2, 2, nil, 2, 3, nil],
         [12, 4, 3, 3, nil, 3, 4, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
         [nil, nil, nil, nil, nil, nil, 6, nil],
        ],
        #Crystalmine
        [[1, 1, 1, 1, nil, 1, 1, nil],
         [3, 2, 2, 2, nil, 2, 2, 1],
         [5, 2, 2, 3, nil, 3, 3, 2],
         [8, 3, 3, 4, nil, 4, 4, 3],
         [12, 3, 4, 4, nil, 4, 4, 4],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
         [nil, nil, nil, nil, nil, nil, nil, 6],
        ]
    ]
    inserts = []

    transaction do
      BuildingtypeRequire.find_each do |bt|
        bt.destroy
      end
    end

    puts "Fix requirements for buildingtypes..."

    for type in 0..7
      puts "Working at '" + t[type] + "' ("+ ((type+1)*12.5).to_i.to_s + "%)"
      name = t[type]
      for lvl in 0..19
        from_elem = Buildingtype.where(name: name, level: lvl+1)
        unless from_elem.nil? || from_elem.empty? then
          for req_lvl in 0..7
            unless req_lvl.nil? then
              levelto = reqs[type][lvl][req_lvl]
              nameto =  t[req_lvl]
              unless levelto.nil? then
                to_elem = Buildingtype.where(name: nameto, level: levelto)

                unless to_elem.nil? || to_elem.empty? then
                  from = from_elem.first
                  to = to_elem.first
                  inserts.push({:buildingtype_id => from.id, :requirement_id => to.id})
                end
              end
            end
          end
        end
      end
    end

    self.transaction do
      BuildingtypeRequire.create(inserts)
    end

    puts "Building requirements used: "+inserts.count.to_s

  end

end
