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

ActiveRecord::Schema.define(version: 20170216233026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.integer  "band_id",     null: false
    t.string   "name",        null: false
    t.string   "live_studio", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "albums", ["name"], name: "index_albums_on_name", unique: true, using: :btree

  create_table "bands", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bands", ["name"], name: "index_bands_on_name", unique: true, using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "track_id",   null: false
    t.text     "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notes", ["user_id", "track_id"], name: "index_notes_on_user_id_and_track_id", unique: true, using: :btree

  create_table "tracks", force: :cascade do |t|
    t.integer  "album_id",      null: false
    t.string   "bonus_regular", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            null: false
    t.string   "password_digest",                  null: false
    t.string   "session_token"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "activated",        default: false, null: false
    t.string   "activation_token",                 null: false
    t.boolean  "admin",            default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree

end
