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

ActiveRecord::Schema.define(version: 20180420011817) do

  create_table "bases", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "memo_h",     limit: 255
    t.text     "memo",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "student_id",  limit: 4
    t.datetime "schedule_at"
    t.string   "mentor",      limit: 255
    t.text     "memo",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checkbox"
    t.integer  "base_id",     limit: 4
  end

  create_table "students", force: :cascade do |t|
    t.integer  "term",             limit: 4
    t.string   "family_name",      limit: 255
    t.string   "first_name",       limit: 255
    t.string   "family_name_kana", limit: 255
    t.string   "first_name_kana",  limit: 255
    t.text     "sheet",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "detail",           limit: 255
    t.integer  "base_id",          limit: 4
  end

  create_table "terms", force: :cascade do |t|
    t.integer  "term_i",     limit: 4
    t.string   "term_t",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
