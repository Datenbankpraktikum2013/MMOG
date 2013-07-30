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

ActiveRecord::Schema.define(version: 20130730102936) do

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

  create_table "sunsystems", force: true do |t|
    t.integer  "y"
    t.string   "name"
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
