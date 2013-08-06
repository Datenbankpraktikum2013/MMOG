module TechnologiesHelper

  def self.init_Technology
   puts 'Create Technologies... (100%)'
    Technology.create({:name => 'increased_income', :factor => 1.05, :cost => 100, :maxrank => -1,:duration => 10, :title => "höheres Einkommen",
                      :description => ' Erhöht dein Einkommen pro Stufe'})
    Technology.create({:name => 'increased_ironproduction', :factor => 1.05, :cost => 80, :maxrank => -1,:duration => 1, :title => "größere Eisenerzproduktion",
                       :description => ' Erhöht deine Eisenproduktion pro Stufe'})
    Technology.create({:name => 'increased_research', :factor => 1.02, :cost => 140, :maxrank => -1,:duration => 1, :title => "kürzere Forschungsdauert",
                       :description => ' Beschleunigt deine Forschung pro Stufe '})
    Technology.create({:name => 'increased_energy_efficiency', :factor => 1.02, :cost => 90, :maxrank => -1,:duration => 1, :title => "bessere Energieeffizienz",
                       :description => ' Veringert deine Energiekosten pro Stufe'})
    Technology.create({:name => 'increased_power', :factor => 1.04, :cost => 80, :maxrank => -1,:duration => 1, :title => "stärkere Feuerkraft",
                      :description => ' Erhöht die Feuerkraft deine Schiffe pro Stufe'})
    Technology.create({:name => 'increased_defense', :factor => 1.03, :cost => 70, :maxrank => -1,:duration => 1, :title => "verstärkte Schilde",
                      :description => ' Verbessert die Verteidigung deiner Schiffe pro Stufe'})
    Technology.create({:name => 'increased_spypower', :factor => 1.05, :cost => 110, :maxrank => -1,:duration => 1, :title => "bessere Erkundungserfolge",
                       :description => ' Erhöht die Spionagewerte deiner Sonden pro Stufe'})
    Technology.create({:name => 'increased_capacaty', :factor => 1.25, :cost => 90, :maxrank => 3,:duration => 1, :title => "größere Kapazität",
                      :description => ' Erhöht die Ladekapazität deiner Schiffe pro Stufe'})
    Technology.create({:name => 'increased_movement', :factor => 1.05, :cost => 120, :maxrank => -1,:duration => 1, :title => "schnellere Schiffe",
                       :description => ' Erhöht die Geschwindigkeit deiner Schiffe pro Stufe'})
    Technology.create({:name => 'large_cargo_ship', :factor => 0, :cost => 140, :maxrank => 1,:duration => 1, :title => "großes Transportschiff",
                       :description => ' Erforsche ein großes Transportschiff um Rohstoffe zu transportieren'})
    Technology.create({:name => 'large_defense_platform', :factor => 0, :cost => 200, :maxrank => 1,:duration => 1, :title => "große Verteidigungsplattform",
                       :description => ' Erforsche eine grße verteidigunsplattform um deinen Planeten zu sichern'})
    Technology.create({:name => 'big_house', :factor => 0, :cost => 100, :maxrank => 3,:duration => 1, :title => "größere Häuser",
                       :description => ' Erhöht den Platz in deinen Gebäuden pro Stufe (Maxrank:3)'})
    Technology.create({:name => 'destroyer', :factor => 0, :cost => 100, :maxrank => 1,:duration => 1, :title => "Zerstörer",
                       :description => ' Erfosche einen Zerstörer um Raubzüge zu starten'})
    Technology.create({:name => 'cruiser', :factor => 0, :cost => 250, :maxrank => 1, :duration => 1, :title => "Kreuzer",
                      :description => ' Erforsche einen mächtigen Kreuzer um fremde Planeten zu erobern'})
    Technology.create({:name => 'hyperspacetechnology', :factor => 0, :cost => 350, :maxrank => 1,:duration => 1, :title => "Warp-Antrieb",
                      :description => ' Ermöglicht deinen Schiffen Hyperraumsprünge zu vollziehen'})
    Technology.create({:name => 'deathstar', :factor => 0, :cost => 400, :maxrank => 1,:duration => 1, :title => "Todesstern",
                       :description => ' Erforsche einen furchteinflößenden Todesstern um deine Feinde zu zermalmen.'})
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
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_capacaty').first.id, :building_rank => 2,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'increased_movement').first.id, :building_rank => 3,
                              :pre_tech_id => 0, :pre_tech_rank => 0})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'large_cargo_ship').first.id, :building_rank => 3,
                              :pre_tech_id => Technology.where(:name => 'increased_capacaty').first.id,
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
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'hyperspacetechnology').first.id, :building_rank =>4 ,
                              :pre_tech_id => Technology.where(:name => 'increased_movement').first.id,
                              :pre_tech_rank => 4})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'deathstar').first.id, :building_rank =>5 ,
                              :pre_tech_id => Technology.where(:name => 'cruiser').first.id,
                              :pre_tech_rank => 1})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'deathstar').first.id, :building_rank =>5 ,
                              :pre_tech_id => Technology.where(:name => 'increased_power').first.id,
                              :pre_tech_rank => 8})
    TechnologyRequire.create({:tech_id => Technology.where(:name => 'deathstar').first.id, :building_rank =>5 ,
                              :pre_tech_id => Technology.where(:name => 'hyperspacetechnology').first.id,
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


