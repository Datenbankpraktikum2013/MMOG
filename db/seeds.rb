# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Default-Werte von Planeten und Gebäude

# Auskommentiert, damit schneller laedt
$game_settings = Hash.new()
$game_settings[:world_length] = 5
$game_settings[:world_view_length] = 5
GalaxiesHelper.generateRegion(0,0,4,4)

#Default-Werte von Technologien

#######Default Technologies

TechnologiesHelper.init_Technology
TechnologiesHelper.init_Technology_Require
TechnologiesHelper.test_user_technology



#Default-Missionstypen
Mission.create({:id => 1, :info_text => "Based"})
Mission.create({:id => 2, :info_text => "Colonization"})
Mission.create({:id => 3, :info_text => "Attack"})
Mission.create({:id => 4, :info_text => "Travel"})
Mission.create({:id => 5, :info_text => "Spy"})
Mission.create({:id => 6, :info_text => "Transport"})

#Default-Werte von Schiffe und Missionen
Ship.create({:construction_time => 1, :offense => 1, :defense => 10, :crystal_cost => 0, :credit_cost => 10, :ore_cost => 5, :name => 'Small cargo ship', :velocity => 3, :crew_capacity => 1, :ressource_capacity => 500, :fuel_capacity => 500, :consumption => 2})
Ship.create({:construction_time => 1, :offense => 1, :defense => 20, :crystal_cost => 0, :credit_cost => 20, :ore_cost => 20, :name => 'Large cargo ship', :velocity => 3, :crew_capacity => 3, :ressource_capacity => 3000, :fuel_capacity => 3000, :consumption => 3})
Ship.create({:construction_time => 1, :offense => 20, :defense => 20, :crystal_cost => 0, :credit_cost => 5, :ore_cost => 5, :name => 'Fighter', :velocity => 6, :crew_capacity => 1, :ressource_capacity => 10, :fuel_capacity => 100, :consumption => 1})
Ship.create({:construction_time => 1, :offense => 30, :defense => 30, :crystal_cost => 0, :credit_cost => 10, :ore_cost => 20, :name => 'Destroyer', :velocity => 5, :crew_capacity => 15, :ressource_capacity => 50, :fuel_capacity => 2000, :consumption => 4})
Ship.create({:construction_time => 1, :offense => 30, :defense => 40, :crystal_cost => 1, :credit_cost => 15, :ore_cost => 30, :name => 'Cruiser', :velocity => 6, :crew_capacity => 20, :ressource_capacity => 150, :fuel_capacity => 3000, :consumption => 4})
Ship.create({:construction_time => 1, :offense => 200, :defense => 100, :crystal_cost => 20, :credit_cost => 1000, :ore_cost => 1000, :name => 'Deathstar', :velocity => 3, :crew_capacity => 500, :ressource_capacity => 2500, :fuel_capacity => 5000, :consumption => 10})
Ship.create({:construction_time => 1, :offense => 0, :defense => 0, :crystal_cost => 0, :credit_cost => 5, :ore_cost => 5, :name => 'Spy drone', :velocity => 15, :crew_capacity => 0, :ressource_capacity => 0, :fuel_capacity => 500, :consumption => 1})
Ship.create({:construction_time => 1, :offense => 1, :defense => 100, :crystal_cost => 0, :credit_cost => 0, :ore_cost => 15, :name => 'Small defense platform', :velocity => 1, :crew_capacity => 3, :ressource_capacity => 0, :fuel_capacity => 0, :consumption => 1})
Ship.create({:construction_time => 1, :offense => 1, :defense => 300, :crystal_cost => 0, :credit_cost => 0, :ore_cost => 30, :name => 'Large defense platform', :velocity => 1, :crew_capacity => 6, :ressource_capacity => 0, :fuel_capacity => 0, :consumption => 1})
Ship.create({:construction_time => 1, :offense => 1, :defense => 10, :crystal_cost => 0, :credit_cost => 20, :ore_cost => 50, :name => 'Colony ship', :velocity => 2, :crew_capacity => 5, :ressource_capacity => 1000, :fuel_capacity => 3000, :consumption => 4})

#Default-Werte von Spieler, Allianzen und Nachrichten
#Alliance.create({:name => 'test_alliance3', :description => 'testtesttest', :user_id => User.first})

##########DEFAULT USER!! demo:praktikum
User.create(:email => 'demo@demo.com',:password => 'password',:username => 'demo',:money => 100,:score => 0)
User.create(:email => 'demo2@demo.com',:password => 'password',:username=> 'demo2',:money => 10000,:score => 0)


#Buildingtypes
Buildingtype.create({:name =>'Headquarter', :level=> 1, :production=> 1, :energyusage=> 0})
Buildingtype.create({:name =>'Oremine', :level=> 1, :production=> 10, :energyusage=>0})
Buildingtype.create({:name =>'Powerplant', :level => 1, :production=> 10, :energyusage=>0})
Buildingtype.create({:name =>'Research Lab', :level => 1, :production=> 0, :energyusage=> 30})
Buildingtype.create({:name =>'City', :level=> 1, :production=> 100, :energyusage=> 20})
Buildingtype.create({:name =>'Depot', :level=> 1, :production=> 200, :energyusage=> 5})
Buildingtype.create({:name =>'Crystalmine', :level=> 1, :production=> 1, :energyusage=> 100})
Buildingtype.create({:name =>'Starport', :level=> 1, :production=> 0, :energyusage=> 100})
