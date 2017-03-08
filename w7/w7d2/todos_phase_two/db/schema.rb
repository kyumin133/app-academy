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

ActiveRecord::Schema.define(version: 20170307235712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "steps", force: :cascade do |t|
    t.string   "title",                      null: false
    t.string   "body",                       null: false
    t.boolean  "done",       default: false, null: false
    t.integer  "todo_id",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "steps", ["todo_id"], name: "index_steps_on_todo_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",     null: false
    t.integer  "todo_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["tag_id", "todo_id"], name: "index_taggings_on_tag_id_and_todo_id", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "tag",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["tag"], name: "index_tags_on_tag", unique: true, using: :btree

  create_table "todos", force: :cascade do |t|
    t.string   "title",                      null: false
    t.string   "body",                       null: false
    t.boolean  "done",       default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
