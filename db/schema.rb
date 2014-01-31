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

ActiveRecord::Schema.define(version: 20140131212639) do

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "ressources", force: true do |t|
    t.integer  "resolved_id"
    t.string   "resolved_title"
    t.string   "resolved_url"
    t.boolean  "favorite"
    t.integer  "status"
    t.text     "excerpt"
    t.integer  "word_count"
    t.datetime "time_added"
    t.datetime "time_updated"
    t.datetime "time_read"
    t.datetime "time_favorited"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id"
  end

  add_index "ressources", ["topic_id"], name: "index_ressources_on_topic_id"

  create_table "topic_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "topic_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "topic_anc_desc_udx", unique: true
  add_index "topic_hierarchies", ["descendant_id"], name: "topic_desc_idx"

  create_table "topics", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["parent_id"], name: "index_topics_on_parent_id"

  create_table "users", force: true do |t|
    t.string   "pocket_username"
    t.string   "pocket_code"
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["pocket_username"], name: "index_users_on_pocket_username", unique: true
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true

end
