# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Konstanten und Standardwerte bitte als Strings in den GameSettings eintragen
# Eintragen: GameSettings.set "key", "value"
# Abfragen: GameSettings.get "key"

GameSettings.set "INITIAL_BUDGET", "1000"
GameSettings.set "PLANET_MIN_SIZE", "10000"
GameSettings.set "PLANET_MAX_SIZE", "100000"
GameSettings.set "WORLD_DISTANCE_FACTOR", "60"
GameSettings.set "WORLD_LENGTH", "5"
GameSettings.set "WORLD_VIEW_LENGTH", "5"
GameSettings.set "SUCCESSMSG_ALLIANCE_MASSMAILSENT", "Rundmail wurde erfolgreich versendet."
GameSettings.set "ERRMSG_ALLIANCE_MASSMAILSENT", "Rundmail konnte nicht versendet werden."
GameSettings.set "SUCCESSMSG_ALLIANCE_CHANGEDDEFAULTRANK", "Standardrang wurde erfolgreich geändert."
GameSettings.set "ERRMSG_ALLIANCE_CHANGEDDEFAULTRANK", "Standardrang konnte nicht geändert werden."
GameSettings.set "SUCCESSMSG_ALLIANCE_CHANGEDDESCRIPTION", "Beschreibung wurde erfolgreich geändert."
GameSettings.set "ERRMSG_ALLIANCE_CHANGEDDESCRIPTION", "Beschreibung konnte nicht geändert werden."
GameSettings.set "SUCCESSMSG_ALLIANCE_CHANGEDUSERRANK","Mitglied erfolgreich bearbeitet."
GameSettings.set "ERRMSG_ALLIANCE_CHANGEDUSERRANK", "Mitglied konnte nicht bearbeitet werden."
GameSettings.set "ERRMSG_ALLIANCE_SHOWEDIT", "Du hast keine Berechtigung, diese Allianz zu editieren."
GameSettings.set "ERRMSG_ALLIANCE_USERALLIANCENOTNIL", "Hey, du hast bereits eine Allianz!"
GameSettings.set "SUCCESSMSG_ALLIANCE_USERADDED","Mitglied erfolgreich hinzugefügt"
GameSettings.set "ERRMSG_ALLIANCE_USERADDED", "Mitglied konnte nicht hinzugefügt werden."

#Default-Werte von Planeten und Gebäudeer

GalaxiesHelper.generateAt(0,0)
Buildingtype.init()

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
Ship.create({:id => 1, :construction_time => 1, :offense => 1, :defense => 10, :crystal_cost => 0, :credit_cost => 10, :ore_cost => 5, :name => 'Small cargo ship', :velocity => 3, :crew_capacity => 1, :ressource_capacity => 500, :fuel_capacity => 500, :consumption => 2})
Ship.create({:id => 2, :construction_time => 1, :offense => 1, :defense => 20, :crystal_cost => 0, :credit_cost => 20, :ore_cost => 20, :name => 'Large cargo ship', :velocity => 3, :crew_capacity => 3, :ressource_capacity => 3000, :fuel_capacity => 3000, :consumption => 3})
Ship.create({:id => 3, :construction_time => 1, :offense => 20, :defense => 20, :crystal_cost => 0, :credit_cost => 5, :ore_cost => 5, :name => 'Fighter', :velocity => 6, :crew_capacity => 1, :ressource_capacity => 10, :fuel_capacity => 100, :consumption => 1})
Ship.create({:id => 4, :construction_time => 1, :offense => 30, :defense => 30, :crystal_cost => 0, :credit_cost => 10, :ore_cost => 20, :name => 'Destroyer', :velocity => 5, :crew_capacity => 15, :ressource_capacity => 50, :fuel_capacity => 2000, :consumption => 4})
Ship.create({:id => 5, :construction_time => 1, :offense => 30, :defense => 40, :crystal_cost => 1, :credit_cost => 15, :ore_cost => 30, :name => 'Cruiser', :velocity => 6, :crew_capacity => 20, :ressource_capacity => 150, :fuel_capacity => 3000, :consumption => 4})
Ship.create({:id => 6, :construction_time => 1, :offense => 200, :defense => 100, :crystal_cost => 20, :credit_cost => 1000, :ore_cost => 1000, :name => 'Deathstar', :velocity => 3, :crew_capacity => 500, :ressource_capacity => 2500, :fuel_capacity => 5000, :consumption => 10})
Ship.create({:id => 7, :construction_time => 1, :offense => 0, :defense => 0, :crystal_cost => 0, :credit_cost => 5, :ore_cost => 5, :name => 'Spy drone', :velocity => 15, :crew_capacity => 0, :ressource_capacity => 0, :fuel_capacity => 500, :consumption => 1})
Ship.create({:id => 8, :construction_time => 1, :offense => 1, :defense => 100, :crystal_cost => 0, :credit_cost => 0, :ore_cost => 15, :name => 'Small defense platform', :velocity => 0, :crew_capacity => 3, :ressource_capacity => 0, :fuel_capacity => 0, :consumption => 0})
Ship.create({:id => 9, :construction_time => 1, :offense => 1, :defense => 300, :crystal_cost => 0, :credit_cost => 0, :ore_cost => 30, :name => 'Large defense platform', :velocity => 0, :crew_capacity => 6, :ressource_capacity => 0, :fuel_capacity => 0, :consumption => 0})
Ship.create({:id => 10, :construction_time => 1, :offense => 1, :defense => 10, :crystal_cost => 0, :credit_cost => 20, :ore_cost => 50, :name => 'Colony ship', :velocity => 2, :crew_capacity => 5, :ressource_capacity => 1000, :fuel_capacity => 3000, :consumption => 4})


#Building Prerequisites for ships
Ship.find(1).buildingtypes << Buildingtype.where(name: "Starport", level: 1).first
Ship.find(2).buildingtypes << Buildingtype.where(name: "Starport", level: 2).first
Ship.find(3).buildingtypes << Buildingtype.where(name: "Starport", level: 1).first
Ship.find(4).buildingtypes << Buildingtype.where(name: "Starport", level: 3).first
Ship.find(5).buildingtypes << Buildingtype.where(name: "Starport", level: 4).first
Ship.find(6).buildingtypes << Buildingtype.where(name: "Starport", level: 5).first
Ship.find(7).buildingtypes << Buildingtype.where(name: "Starport", level: 1).first
Ship.find(8).buildingtypes << Buildingtype.where(name: "Starport", level: 1).first
Ship.find(9).buildingtypes << Buildingtype.where(name: "Starport", level: 2).first
Ship.find(10).buildingtypes << Buildingtype.where(name: "Starport", level: 3).first

#Building 
Building.create({:planet_id => 1, :buildingtype_id => 1})
Building.create({:planet_id => 1, :buildingtype_id => 2})
Building.create({:planet_id => 1, :buildingtype_id => 36})

#Default-Werte von Spieler, Allianzen und Nachrichten
#Alliance.create({:name => 'test_alliance3', :description => 'testtesttest', :user_id => User.first})

##########DEFAULT USER!! demo:praktikum
User.create(:email => 'demo@demo.com',:password => 'password',:username => 'demo',:score => 0)
User.create(:email => 'demo2@demo.com',:password => 'password',:username=> 'demo2',:money => 12000,:score => 0)
User.create(:email => 'demo3@demo.com',:password => 'password',:username=> 'demo3',:money => 12000,:score => 0)
User.create(:email => 'demo4@demo.com',:password => 'password',:username=> 'demo4',:money => 12000,:score => 0)


# Testing values
#Planet.find(1).claim(User.find(1))
#Fleet.new(Planet.find(1))
#Fleet.find(1).add_ships({Ship.find(1)=> 50, Ship.find(2)=> 50, Ship.find(3)=> 50, Ship.find(4)=> 50, Ship.find(5)=> 50,Ship.find(6)=> 50,Ship.find(7)=> 50,Ship.find(8)=> 50,Ship.find(9)=> 50,Ship.find(10)=> 50})
#Planet.find(1).give(:Ore, 10000)
#Planet.find(1).give(:Crystal, 10000)
#Planet.find(1).give(:Money, 10000)
#Planet.find(1).give(:Population, 10000)
#Planet.find(1).give(:Energy, 10000)
#Fleet.find(1).load_ressources(100, 100, 100, Planet.find(1))