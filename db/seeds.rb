# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Default-Werte von Planeten und Gebäude

#Default-Werte von Technologien

#######Default Technologies
Technology.create({:name => 'increased_income', :factor => 1.05, :cost => 100})
Technology.create({:name => 'increased_ironproduction', :factor => 1.05, :cost => 80})
Technology.create({:name => 'increased_research', :factor => 1.02, :cost => 140})
Technology.create({:name => 'increased_energie_efficiency', :factor => 1.02, :cost => 90})
Technology.create({:name => 'increased_power', :factor => 1.04, :cost => 80})
Technology.create({:name => 'increased_defense', :factor => 1.03, :cost => 70})
Technology.create({:name => 'increased_spypower', :factor => 1.05, :cost => 110})
Technology.create({:name => 'increased_capacaty', :factor => 1.25, :cost => 90})
Technology.create({:name => 'increased_moement', :factor => 1.05, :cost => 120})
Technology.create({:name => 'large_cargo_ship', :factor => 0, :cost => 140})
Technology.create({:name => 'large_defense_platform', :factor => 0, :cost => 200})
Technology.create({:name => 'big_house', :factor => 0, :cost => 100})
Technology.create({:name => 'destroyer', :factor => 0, :cost => 100})
Technology.create({:name => 'cruiser', :factor => 0, :cost => 250})
Technology.create({:name => 'hyperspacetechnology', :factor => 0, :cost => 350})
Technology.create({:name => 'deathstar', :factor => 0, :cost => 400})






#Default-Werte von Schiffe und Missionen
Ship.create({:construction_time => 1, :offense => 1, :defense => 10, :crystal_cost => 0, :credit_cost => 10, :ore_cost => 5, :name => 'Small cargo ship', :velocity => 3, :crew_capacity => 1, :ressource_capasity => 500, :fuel_capacity => 500, :consumption => 2})
Ship.create({:construction_time => 1, :offense => 1, :defense => 20, :crystal_cost => 0, :credit_cost => 20, :ore_cost => 20, :name => 'Large cargo ship', :velocity => 3, :crew_capacity => 3, :ressource_capasity => 3000, :fuel_capacity => 3000, :consumption => 3})
Ship.create({:construction_time => 1, :offense => 20, :defense => 20, :crystal_cost => 0, :credit_cost => 5, :ore_cost => 5, :name => 'Fighter', :velocity => 6, :crew_capacity => 1, :ressource_capasity => 10, :fuel_capacity => 100, :consumption => 1})
Ship.create({:construction_time => 1, :offense => 30, :defense => 30, :crystal_cost => 0, :credit_cost => 10, :ore_cost => 20, :name => 'destroyer', :velocity => 5, :crew_capacity => 15, :ressource_capasity => 50, :fuel_capacity => 2000, :consumption => 4})
Ship.create({:construction_time => 1, :offense => 30, :defense => 40, :crystal_cost => 1, :credit_cost => 15, :ore_cost => 30, :name => 'cruiser', :velocity => 6, :crew_capacity => 20, :ressource_capasity => 150, :fuel_capacity => 3000, :consumption => 4})
Ship.create({:construction_time => 1, :offense => 200, :defense => 100, :crystal_cost => 20, :credit_cost => 1000, :ore_cost => 1000, :name => 'deathstar', :velocity => 3, :crew_capacity => 500, :ressource_capasity => 2500, :fuel_capacity => 5000, :consumption => 10})
Ship.create({:construction_time => 1, :offense => 0, :defense => 0, :crystal_cost => 0, :credit_cost => 5, :ore_cost => 5, :name => 'Spy drone', :velocity => 15, :crew_capacity => 0, :ressource_capasity => 0, :fuel_capacity => 500, :consumption => 1})
Ship.create({:construction_time => 1, :offense => 1, :defense => 100, :crystal_cost => 0, :credit_cost => 0, :ore_cost => 15, :name => 'Small defense platform', :velocity => 0, :crew_capacity => 3, :ressource_capasity => 0, :fuel_capacity => 0, :consumption => 0})
Ship.create({:construction_time => 1, :offense => 1, :defense => 300, :crystal_cost => 0, :credit_cost => 0, :ore_cost => 30, :name => 'Large defense platform', :velocity => 0, :crew_capacity => 6, :ressource_capasity => 0, :fuel_capacity => 0, :consumption => 0})
Ship.create({:construction_time => 1, :offense => 1, :defense => 10, :crystal_cost => 0, :credit_cost => 20, :ore_cost => 50, :name => 'Colony ship', :velocity => 2, :crew_capacity => 5, :ressource_capasity => 1000, :fuel_capacity => 3000, :consumption => 4})

#Default-Werte von Spieler, Allianzen und Nachrichten
Alliance.create({:name => 'test_alliance3', :description => 'testtesttest'})

##########DEFAULT USER!! demo:praktikum
User.create(:email => 'demo@demo.com',:password => 'praktikum',:username => 'demo',:money => 100,:score => 0)
