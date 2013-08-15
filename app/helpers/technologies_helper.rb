module TechnologiesHelper

  def self.init_Technology
    puts 'Create Technologies... (100%)'
    Technology.create({:name => 'increased_income', :factor => 1.05, :cost => 100, :maxrank => -1,:duration => 5, :title => "höheres Einkommen",
                       :description => ' Erhöht dein Einkommen pro Stufe um 5%. Zeit zu Demo-Zwecken heruntergesetzt.'})
    Technology.create({:name => 'increased_ironproduction', :factor => 1.05, :cost => 80, :maxrank => -1,:duration => 1200, :title => "größere Eisenerzproduktion",
                       :description => ' Erhöht deine Eisenproduktion pro Stufe 5% '})
    Technology.create({:name => 'increased_research', :factor => 1.2, :cost => 140, :maxrank => -1,:duration => 1800, :title => "kürzere Forschungsdauer",
                       :description => ' Verringert deine Forschungsdauer 1,2^Stufe '})
    Technology.create({:name => 'increased_energy_efficiency', :factor => 1.1, :cost => 90, :maxrank => -1,:duration => 900, :title => "bessere Energieeffizienz",
                       :description => ' Veringert deine Energiekosten pro Stufe 10% '})
    Technology.create({:name => 'increased_power', :factor => 1.04, :cost => 80, :maxrank => -1,:duration => 2400, :title => "stärkere Feuerkraft",
                       :description => ' Erhöht die Feuerkraft deine Schiffe pro Stufe 4%'})
    Technology.create({:name => 'increased_defense', :factor => 1.03, :cost => 70, :maxrank => -1,:duration => 1800, :title => "verstärkte Schilde",
                       :description => ' Verbessert die Verteidigung deiner Schiffe pro Stufe 3%'})
    Technology.create({:name => 'increased_spypower', :factor => 1.05, :cost => 110, :maxrank => -1,:duration => 4200, :title => "bessere Erkundungserfolge",
                       :description => ' Erhöht die Spionagewerte deiner Sonden pro Stufe 5% '})
    Technology.create({:name => 'increased_capacity', :factor => 1.25, :cost => 90, :maxrank => 3,:duration => 900, :title => "größere Kapazität",
                       :description => ' Erhöht die Ladekapazität deiner Schiffe pro Stufe 25% (Maxrank:3)', :score => 20})
    Technology.create({:name => 'increased_movement', :factor => 1.05, :cost => 120, :maxrank => -1,:duration => 1200, :title => "schnellere Schiffe",
                       :description => ' Erhöht die Geschwindigkeit deiner Schiffe pro Stufe 5%'})
    Technology.create({:name => 'large_cargo_ship', :factor => 0, :cost => 140, :maxrank => 1,:duration => 3600*12, :title => "großes Transportschiff",
                       :description => ' Erforsche ein großes Transportschiff um Rohstoffe zu transportieren', :score => 50})
    Technology.create({:name => 'large_defense_platform', :factor => 0, :cost => 200, :maxrank => 1,:duration => 3600*24, :title => "große Verteidigungsplattform",
                       :description => ' Erforsche eine große Verteidigunsplattform um deinen Planeten zu sichern', :score => 50})
    Technology.create({:name => 'big_house', :factor => 0, :cost => 100, :maxrank => 3,:duration => 3600*6, :title => "größere Häuser",
                       :description => ' Erhöht den Platz in deinen Gebäuden pro Stufe (Maxrank:3)', :score => 20})
    Technology.create({:name => 'destroyer', :factor => 0, :cost => 100, :maxrank => 1,:duration => 3600*18, :title => "Zerstörer",
                       :description => ' Erfosche einen Zerstörer um Raubzüge zu starten', :score => 50})
    Technology.create({:name => 'cruiser', :factor => 0, :cost => 250, :maxrank => 1, :duration => 3600*24, :title => "Kreuzer",
                       :description => ' Erforsche einen mächtigen Kreuzer um fremde Planeten zu erobern', :score => 75})
    Technology.create({:name => 'hyperspace_technology', :factor => 0, :cost => 350, :maxrank => 1,:duration => 3600*24, :title => "Warp-Antrieb",
                       :description => ' Ermöglicht deinen Schiffen Hyperraumsprünge zu vollziehen', :score => 100})
    Technology.create({:name => 'deathstar', :factor => 0, :cost => 400, :maxrank => 1,:duration => 3600*48, :title => "Todesstern",
                       :description => ' Erforsche einen furchteinflößenden Todesstern um deine Feinde zu zermalmen.', :score => 500})
  end

  def self.init_Technology_Require

    puts 'Set technology requirements... (100%)'
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_income').first.id, :building_rank => 1,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_ironproduction').first.id, :building_rank => 1,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_research').first.id, :building_rank => 1,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_energy_efficiency').first.id, :building_rank => 1,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_power').first.id, :building_rank => 2,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_defense').first.id, :building_rank => 2,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_spypower').first.id, :building_rank => 2,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_capacity').first.id, :building_rank => 2,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_movement').first.id, :building_rank => 3,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'large_cargo_ship').first.id, :building_rank => 3,
                              :pre_tech_id => Technology.where(:name => 'increased_capacity').first.id,
                              :pre_tech_rank => 1})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'big_house').first.id, :building_rank =>3 ,
                              :pre_tech_id => Technology.where(:name => 'increased_energy_efficiency').first.id,
                              :pre_tech_rank => 1})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'destroyer').first.id, :building_rank =>3 ,
                              :pre_tech_id => Technology.where(:name => 'increased_power').first.id,
                              :pre_tech_rank => 1})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'large_defense_platform').first.id, :building_rank =>4 ,
                              :pre_tech_id => Technology.where(:name => 'increased_defense').first.id,
                              :pre_tech_rank => 4})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'cruiser').first.id, :building_rank =>4 ,
                              :pre_tech_id => Technology.where(:name => 'destroyer').first.id,
                              :pre_tech_rank => 1})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'cruiser').first.id, :building_rank =>4 ,
                              :pre_tech_id => Technology.where(:name => 'increased_power').first.id,
                              :pre_tech_rank => 4})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'hyperspace_technology').first.id, :building_rank =>4 ,
                              :pre_tech_id => Technology.where(:name => 'increased_movement').first.id,
                              :pre_tech_rank => 4})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'deathstar').first.id, :building_rank =>5 ,
                              :pre_tech_id => Technology.where(:name => 'cruiser').first.id,
                              :pre_tech_rank => 1})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'deathstar').first.id, :building_rank =>5 ,
                              :pre_tech_id => Technology.where(:name => 'increased_power').first.id,
                              :pre_tech_rank => 8})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'deathstar').first.id, :building_rank =>5 ,
                              :pre_tech_id => Technology.where(:name => 'hyperspace_technology').first.id,
                              :pre_tech_rank => 1})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'deathstar').first.id, :building_rank =>5 ,
                              :pre_tech_id => Technology.where(:name => 'increased_defense').first.id,
                              :pre_tech_rank => 8})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'deathstar').first.id, :building_rank =>5 ,
                              :pre_tech_id => Technology.where(:name => 'increased_energy_efficiency').first.id,
                              :pre_tech_rank => 8})

  end

  #test einträge für user technology verknüpfung
  def self.test_user_technology
    UserTechnology.create({:user_id => 1, :technology_id => 1, :rank => 1})
    UserTechnology.create({:user_id => 1, :technology_id => 2, :rank => 2})
    UserTechnology.create({:user_id => 2, :technology_id => 1, :rank => 1})
    UserTechnology.create({:user_id => 2, :technology_id => 2, :rank => 3})
    UserTechnology.create({:user_id => 3, :technology_id => 1, :rank => 2})
    UserTechnology.create({:user_id => 3, :technology_id => 2, :rank => 4})
    UserTechnology.create({:user_id => 3, :technology_id => 4, :rank => 1})
  end

  def self.get_icon_name(tech)
    techname = Technology.find(tech).name
    filename = 'images/icons/' + techname.to_s+'_icon.png'
  end

end


