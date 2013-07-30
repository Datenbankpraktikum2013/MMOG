# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130730124519) do

  create_table "alliances", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buildings", force: true do |t|
    t.integer  "typeid"
    t.datetime "letzteaktion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galaxies", force: true do |t|
    t.integer  "x"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "planets", force: true do |t|
    t.integer  "z"
    t.string   "name"
    t.integer  "spezialisierung"
    t.float    "groesse"
    t.integer  "eisenerz"
    t.integer  "maxeisenerz"
    t.integer  "kristalle"
    t.integer  "maxkristalle"
    t.integer  "energie"
    t.integer  "maxenergie"
    t.integer  "einwohner"
    t.integer  "maxeinwohner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_settings", force: true do |t|
    t.float    "increased_income",            default: 1.0
    t.float    "increased_ironproduction",    default: 1.0
    t.float    "increased_energy_efficiency", default: 1.0
    t.float    "increased_movement",          default: 1.0
    t.float    "big_house",                   default: 1.0
    t.float    "increased_research",          default: 1.0
    t.float    "increased_power",             default: 1.0
    t.float    "increased_defense",           default: 1.0
    t.float    "increased_capacity",          default: 1.0
    t.boolean  "hyperspace_technology",       default: false
    t.boolean  "large_cargo_ship",            default: false
    t.boolean  "large_defenseplattform",      default: false
    t.boolean  "destroyer",                   default: false
    t.boolean  "cruiser",                     default: false
    t.boolean  "deathstar",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", force: true do |t|
    t.string   "name"
    t.boolean  "can_kick"
    t.boolean  "can_massmail"
    t.boolean  "can_edit"
    t.boolean  "can_invite"
    t.boolean  "can_disband"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "alliance_id"
  end

  create_table "sunsystems", force: true do |t|
    t.integer  "y"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technologies", force: true do |t|
    t.string   "name"
    t.float    "factor"
    t.float    "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "nickname"
    t.integer  "money"
    t.integer  "score"
    t.integer  "alliance_id"
    t.integer  "alliance_rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
