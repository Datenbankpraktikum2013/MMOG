module SunsystemsHelper      #

  def self.namegen()
    prename = ["Attori", "Arkada", "Berilla", "Blossom", "Cronta", "Curomia", "Drya", "Dorgshi", "Ewok", "Enemy", "Fijun", "Flake", "Gadaia", "Goorn", "Halo", "Hopeless", "Illindor", "Irfan", "Jona", "Japikur", "Kanton", "Kyndir", "Lathia", "Loougast", "Modrum", "Melista", "Naja", "Nephrem", "Orelio", "Outside", "Pendal", "Punta", "Quam", "Quokan", "Redeye", "Reality", "Schlupfloch", "Shant", "Thermis", "Tryfuner", "Utopia", "Ultra", "Velander", "Visalia", "Wega", "Wheel", "Xerasch", "Xudoman", "Yangar", "Yuyda", "Zaukula", "Zhaklaan"]
    letter = ["A","B","C","D","E","F","G","1", "2", "3", "4", "5", "6"]
    x = Random.rand(prename.length)
    prename[x] + "-" + letter[Random.rand(letter.length)] + letter[Random.rand(letter.length)].downcase

  end

end
