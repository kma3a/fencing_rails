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

ActiveRecord::Schema.define(version: 20140808212915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coaches", force: true do |t|
    t.string   "name",                   default: "Coach", null: false
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coaches", ["email"], name: "index_coaches_on_email", unique: true, using: :btree
  add_index "coaches", ["reset_password_token"], name: "index_coaches_on_reset_password_token", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.integer  "team_id"
    t.string   "secret_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "headcoaches", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.integer  "event_id"
    t.integer  "student_id"
    t.integer  "bout_number"
    t.text     "bout_results"
    t.integer  "victories"
    t.integer  "touches_scored"
    t.integer  "touches_recieved"
    t.integer  "indicator"
    t.integer  "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "secret_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_coaches", force: true do |t|
    t.integer  "team_id"
    t.integer  "coach_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_students", force: true do |t|
    t.integer  "team_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "headcoach_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end