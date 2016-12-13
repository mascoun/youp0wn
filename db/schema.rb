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

ActiveRecord::Schema.define(version: 20161213123722) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "challenges_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["challenges_id"], name: "index_categories_on_challenges_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.string   "text"
    t.string   "flag"
    t.string   "attachement"
    t.integer  "score"
    t.integer  "contest_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.index ["category_id"], name: "index_challenges_on_category_id"
    t.index ["contest_id"], name: "index_challenges_on_contest_id"
  end

  create_table "contests", force: :cascade do |t|
    t.string   "name",                         null: false
    t.text     "description",                  null: false
    t.datetime "begins",                       null: false
    t.datetime "ends",                         null: false
    t.binary   "photo",       limit: 10485760
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "score",          default: 0
    t.integer  "contest_id"
    t.integer  "fault",          default: 0
    t.text     "challenges_ids", default: "--- []\n"
    t.string   "join_digest"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["contest_id"], name: "index_teams_on_contest_id"
  end

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.index ["team_id", "user_id"], name: "index_teams_users_on_team_id_and_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "school"
    t.boolean  "superuser",         default: false
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "remember_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

end
