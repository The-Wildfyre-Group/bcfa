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

ActiveRecord::Schema.define(version: 20141003000919) do

  create_table "forums", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "topic_id"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.integer  "forum_id"
    t.string   "name"
    t.integer  "last_poster_id"
    t.datetime "last_post_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_details", force: true do |t|
    t.integer  "user_id"
    t.string   "linkedin"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "twitter"
    t.string   "undergraduate_school"
    t.string   "graduate_school"
    t.string   "doctorate_school"
    t.string   "undergraduate_degree"
    t.string   "graduate_degree"
    t.string   "doctorate_degree"
    t.string   "undergraduate_major"
    t.string   "graduate_major"
    t.string   "doctorate_major"
    t.integer  "undergraduate_year"
    t.integer  "graduate_year"
    t.integer  "doctorate_year"
    t.integer  "year_of_charter"
    t.string   "certifications"
    t.string   "company"
    t.string   "title"
    t.string   "industries"
    t.string   "website"
    t.string   "interests"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.text     "bio"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "skills",               default: "{}"
  end

  create_table "user_profile_pictures", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "photo",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_profile_pictures", ["photo"], name: "index_user_profile_pictures_on_photo", using: :btree
  add_index "user_profile_pictures", ["user_id"], name: "index_user_profile_pictures_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "password_digest",        default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "prefix"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "authentication_token"
    t.integer  "invited_by_id"
    t.integer  "invitation_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "level"
    t.boolean  "verified"
    t.string   "slug"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visit_details", force: true do |t|
    t.integer  "visit_id",   null: false
    t.string   "ip_address"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visit_details", ["visit_id"], name: "index_visit_details_on_visit_id", using: :btree

  create_table "visits", force: true do |t|
    t.integer  "visitable_id",   null: false
    t.string   "visitable_type", null: false
    t.integer  "total_visits"
    t.integer  "unique_visits"
    t.string   "controller",     null: false
    t.string   "action",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visits", ["action"], name: "index_visits_on_action", using: :btree
  add_index "visits", ["controller"], name: "index_visits_on_controller", using: :btree
  add_index "visits", ["visitable_id"], name: "index_visits_on_visitable_id", using: :btree
  add_index "visits", ["visitable_type"], name: "index_visits_on_visitable_type", using: :btree

end
