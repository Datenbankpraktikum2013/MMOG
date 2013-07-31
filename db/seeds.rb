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

#Default-Werte von Spieler, Allianzen und Nachrichten
Alliance.create({:name => 'test_alliance3', :description => 'testtesttest'})

##########DEFAULT USER!! demo:praktikum
User.create(:email => 'demo@demo.com',:password => 'praktikum',:username => 'demo',:money => 100,:score => 0)
