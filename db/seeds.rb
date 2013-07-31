# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Default-Werte von Planeten und Gebäude

#Default-Werte von Technologien


#Default-Werte von Schiffe und Missionen

#Default-Werte von Spieler, Allianzen und Nachrichten
Alliance.create({"name" => "test_alliance3", "description" => "testtesttest"})

##########DEFAULT USER!! demo:praktikum
User.create(:email => "demo@demo.com",:password => "praktikum",:username => "demo",:money => 100,:score => 0)
