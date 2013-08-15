# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do

# Konstanten und Standardwerte bitte als Strings in den GameSettings eintragen
# Eintragen: GameSettings.set "key", "value"
# Abfragen: GameSettings.get "key"

GameSettings.set "caching?", true
GameSettings.set "INITIAL_BUDGET", 1000
GameSettings.set "PLANET_MIN_SIZE", 10000
GameSettings.set "PLANET_MAX_SIZE", 100000
GameSettings.set "WORLD_DISTANCE_FACTOR", 60
GameSettings.set "WORLD_LENGTH", 12
GameSettings.set "WORLD_VIEW_LENGTH", 7
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
GameSettings.set "SUCCESSMSG_ALLIANCE_CREATED", "Allianz erfolgreich erstellt."
GameSettings.set "SUCCESSMSG_ALLIANCE_USERREMOVED","Mitglied wurde erfolgreich aus der Allianz entfernt"
GameSettings.set "ERRMSG_ALLIANCE_USERREMOVED", "Mitglied konnte nicht entfernt werden."
GameSettings.set "ERRMSG_ALLIANCE_CREATED", "Allianz konnte nicht erstellt werden!"
GameSettings.set "ERRMSG_MESSAGE_SHOWMESSAGE", "Nachricht kann nicht angezeigt werden."
GameSettings.set "SUCCESSMSG_MESSAGE_CREATED", "Nachricht wurde erfolgreich zugestellt."
GameSettings.set "ERRMSG_RANK_EDIT", "Du kannst diesen Rang nicht bearbeiten"
GameSettings.set "SUCCESSMSG_RANK_CREATED", "Rang wurde erfoglreich erstellt."
GameSettings.set "ERRMSG_RANK_CREATED", "Konnte nicht erstellt werden."
GameSettings.set "ERRMSG_MESSAGE_CREATED", "Nachricht konnte nicht zugestellt werden."
GameSettings.set "ERRMSG_RANK_NEW", "Dir ist es nicht erlaubt, neue Ränge zu erstellen."
GameSettings.set "SUCCESSMSG_RANK_UPDATE", "Rang wurde erfolgreich geändert."
GameSettings.set "ERRMSG_RANK_UPDATE", "Rang konnte nicht geändert werden."
GameSettings.set "SUCCESSMSG_RANK_DESTROY", "Rang wurde erfolgreich gelöscht."
GameSettings.set "ERRMSG_RANK_DESTROY", "Rang konnte nicht gelöscht werden."
GameSettings.set "ACCEPTMSG_REQUESTREACTION","Du hast diese Anfrage angenommen."
GameSettings.set "DECLINEMSG_REQUESTREACTION","Du hast diese Anfrage abgelehnt."
GameSettings.set "ERRMSG_REQUESTREACTION", "Du hast keine Erlaubnis für diese Aktion."
GameSettings.set "SUCCESSMSG_REQUESTCREATE", "Deine Anfrage wurde erfolgreich abgesendet."
GameSettings.set "ERRMSG_REQUESTCREATE", "Deine Anfrage konnte nicht gesendet werden."
GameSettings.set "JAVASCRIPT_REFRESH_UNREAD_MESSAGES_INTERVAL", 10000 #msec
GameSettings.set "SUCCESSMSG_ALLIANCE_LEAVE", "Du bist nun nicht mehr Mitglied dieser Allianz."
GameSettings.set "ERRMSG_ALLIANCE_LEAVE", "Du kannst diese Allianz nicht verlassen."
GameSettings.set "SUCCESSMSG_ALLIANCE_CHANGEFOUNDER", "Du bist zurückgetreten."
GameSettings.set "ERRMSG_ALLIANCE_CHANGEFOUNDER", "Du hast keine Erlaubnis für diese Aktion."
GameSettings.set "ERRMSG_USER_ALREADY_IN_ALLIANCE", "Dieser Benutzer gehört bereits zu einer Allianz."
GameSettings.set "ERRMSG_USER_ALREADY_IN_FRIENDLIST", "Dieser Benutzer ist bereits in deiner Kontaktliste."

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
Ship.create({:id => 1, :construction_time => 240, :offense => 1, :defense => 10, :crystal_cost => 0, :credit_cost => 500, :ore_cost => 220, :name => 'Small cargo ship', :velocity => 3, :crew_capacity => 1, :ressource_capacity => 8000, :fuel_capacity => 1000, :consumption => 2})
Ship.create({:id => 2, :construction_time => 480, :offense => 1, :defense => 30, :crystal_cost => 0, :credit_cost => 2000, :ore_cost => 1200, :name => 'Large cargo ship', :velocity => 3, :crew_capacity => 8, :ressource_capacity => 40000, :fuel_capacity => 6000, :consumption => 3})
Ship.create({:id => 3, :construction_time => 240, :offense => 30, :defense => 30, :crystal_cost => 0, :credit_cost => 100, :ore_cost => 400, :name => 'Fighter', :velocity => 6, :crew_capacity => 1, :ressource_capacity => 10, :fuel_capacity => 100, :consumption => 1})
Ship.create({:id => 4, :construction_time => 540, :offense => 70, :defense => 30, :crystal_cost => 0, :credit_cost => 400, :ore_cost => 1400, :name => 'Destroyer', :velocity => 5, :crew_capacity => 15, :ressource_capacity => 50, :fuel_capacity => 4000, :consumption => 4})
Ship.create({:id => 5, :construction_time => 900, :offense => 150, :defense => 60, :crystal_cost => 1, :credit_cost => 700, :ore_cost => 2000, :name => 'Cruiser', :velocity => 6, :crew_capacity => 20, :ressource_capacity => 150, :fuel_capacity => 6000, :consumption => 4})
Ship.create({:id => 6, :construction_time => 5000, :offense => 10000, :defense => 7000, :crystal_cost => 6666, :credit_cost => 90000, :ore_cost => 90000, :name => 'Deathstar', :velocity => 3, :crew_capacity => 500, :ressource_capacity => 2500, :fuel_capacity => 10000, :consumption => 10})
Ship.create({:id => 7, :construction_time => 480, :offense => 0, :defense => 0, :crystal_cost => 0, :credit_cost => 100, :ore_cost => 150, :name => 'Spy drone', :velocity => 15, :crew_capacity => 0, :ressource_capacity => 0, :fuel_capacity => 1000, :consumption => 1})
Ship.create({:id => 8, :construction_time => 480, :offense => 1, :defense => 50, :crystal_cost => 0, :credit_cost => 0, :ore_cost => 200, :name => 'Small defense platform', :velocity => 0, :crew_capacity => 3, :ressource_capacity => 0, :fuel_capacity => 0, :consumption => 0})
Ship.create({:id => 9, :construction_time => 900, :offense => 1, :defense => 400, :crystal_cost => 0, :credit_cost => 0, :ore_cost => 1400, :name => 'Large defense platform', :velocity => 0, :crew_capacity => 6, :ressource_capacity => 0, :fuel_capacity => 0, :consumption => 0})
Ship.create({:id => 10, :construction_time => 900, :offense => 1, :defense => 10, :crystal_cost => 0, :credit_cost => 2000, :ore_cost => 4000, :name => 'Colony ship', :velocity => 2, :crew_capacity => 5, :ressource_capacity => 1000, :fuel_capacity => 3000, :consumption => 4})


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
Building.create({:planet_id => 1, :buildingtype_id => 54})
Building.create({:planet_id => 1, :buildingtype_id => 30})
Building.create({:planet_id => 2, :buildingtype_id => 1})
Building.create({:planet_id => 2, :buildingtype_id => 2})
Building.create({:planet_id => 2, :buildingtype_id => 51})
Building.create({:planet_id => 4, :buildingtype_id => 1})
Building.create({:planet_id => 4, :buildingtype_id => 2})
Building.create({:planet_id => 4, :buildingtype_id => 51})

#Default-Werte von Spieler, Allianzen und Nachrichten
#Alliance.create({:name => 'test_alliance3', :description => 'testtesttest', :user_id => User.first})

# ##########DEFAULT USER!! demo:praktikum
# User.create(:email => 'demo@demo.com',:password => 'password',:username => 'demo', :money => 12000,:score => 0)
# User.create(:email => 'demo2@demo.com',:password => 'password',:username=> 'demo2',:money => 12000,:score => 0)
# User.create(:email => 'demo3@demo.com',:password => 'password',:username=> 'demo3',:money => 12000,:score => 0)
# User.create(:email => 'demo4@demo.com',:password => 'password',:username=> 'demo4',:money => 12000,:score => 0)

# alliance = Alliance.create(:name => "Test", :description => "Auch")
# alliance.add_user(User.first)
# alliance.set_founder(User.first)
# alliance.add_user(User.find(2))

# # Testing values

# # own
# p=Planet.find(1)
# p.claim(User.find(1))
# Fleet.new(p)
# p.maxore = 100000
# p.maxenergy = 100000
# p.maxcrystal = 100000
# p.maxpopulation = 100000
# p.save
# Fleet.find(1).add_ships({Ship.find(1)=> 5000, Ship.find(2)=> 5000, Ship.find(3)=> 5000, Ship.find(4)=> 5000, Ship.find(5)=> 5000,Ship.find(6)=> 5000,Ship.find(7)=> 5000,Ship.find(8)=> 5000,Ship.find(9)=> 5000,Ship.find(10)=> 5000})
# Planet.find(1).give(:Ore, 10000)
# Planet.find(1).give(:Crystal, 10000)
# Planet.find(1).give(:Money, 10000)
# Planet.find(1).give(:Population, 10000)
# Planet.find(1).give(:Energy, 10000)

# # alliance
# p=Planet.find(2)
# p.claim(User.find(2))
# Fleet.new(p)
# p.maxore = 100000
# p.maxenergy = 100000
# p.maxcrystal = 100000
# p.maxpopulation = 100000
# p.save
# Fleet.find(2).add_ships({Ship.find(1)=> 500, Ship.find(2)=> 500, Ship.find(3)=> 500, Ship.find(4)=> 500, Ship.find(5)=> 500,Ship.find(6)=> 500,Ship.find(7)=> 500,Ship.find(8)=> 500,Ship.find(9)=> 500,Ship.find(10)=> 500})
# Planet.find(1).give(:Ore, 10000)
# Planet.find(1).give(:Crystal, 10000)
# Planet.find(1).give(:Money, 10000)
# Planet.find(1).give(:Population, 10000)
# Planet.find(1).give(:Energy, 10000)

# # enemy
# p=Planet.find(3)
# p.claim(User.find(3))
# Fleet.new(p)
# p.maxore = 100000
# p.maxenergy = 100000
# p.maxcrystal = 100000
# p.maxpopulation = 100000
# p.save
# Fleet.find(3).add_ships({Ship.find(1)=> 50, Ship.find(2)=> 50, Ship.find(3)=> 50, Ship.find(4)=> 50, Ship.find(5)=> 50,Ship.find(6)=> 50,Ship.find(7)=> 50,Ship.find(8)=> 50,Ship.find(9)=> 50,Ship.find(10)=> 50})
# Planet.find(1).give(:Ore, 10000)
# Planet.find(1).give(:Crystal, 10000)
# Planet.find(1).give(:Money, 10000)
# Planet.find(1).give(:Population, 10000)
# Planet.find(1).give(:Energy, 10000)

# # 2nd own
# p=Planet.find(4)
# p.claim(User.find(1))
# Fleet.new(p)
# p.maxore = 100000
# p.maxenergy = 100000
# p.maxcrystal = 100000
# p.maxpopulation = 100000
# p.save
# Fleet.find(1).add_ships({Ship.find(1)=> 50, Ship.find(2)=> 50, Ship.find(3)=> 50, Ship.find(4)=> 50, Ship.find(5)=> 50,Ship.find(6)=> 50,Ship.find(7)=> 50,Ship.find(8)=> 50,Ship.find(9)=> 50,Ship.find(10)=> 50})
# Planet.find(1).give(:Ore, 10000)
# Planet.find(1).give(:Crystal, 10000)
# Planet.find(1).give(:Money, 10000)
# Planet.find(1).give(:Population, 10000)
# Planet.find(1).give(:Energy, 10000)

#    Planet.first.seen_by(User.first)
#    Planet.first.seen_by(User.find(2))
end