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

ActiveRecord::Schema.define(version: 20130927054055) do

  create_table "campaigns", force: true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["project_id"], name: "index_campaigns_on_project_id", using: :btree
  add_index "campaigns", ["user_id"], name: "index_campaigns_on_user_id", using: :btree

  create_table "emails", force: true do |t|
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["address"], name: "index_emails_on_address", using: :btree

  create_table "emails_recollections", id: false, force: true do |t|
    t.integer "email_id"
    t.integer "recollection_id"
  end

  add_index "emails_recollections", ["email_id", "recollection_id"], name: "index_emails_recollections_on_email_id_and_recollection_id", unique: true, using: :btree
  add_index "emails_recollections", ["email_id"], name: "index_emails_recollections_on_email_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "host"
    t.text     "uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages_recollections", force: true do |t|
    t.integer "page_id"
    t.integer "recollection_id"
    t.integer "number_of_emails"
  end

  add_index "pages_recollections", ["page_id", "recollection_id"], name: "index_pages_recollections_on_page_id_and_recollection_id", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recollection_pages", force: true do |t|
    t.integer  "recollection_id"
    t.integer  "page_id"
    t.integer  "number_of_emails"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recollection_pages", ["page_id"], name: "index_recollection_pages_on_page_id", using: :btree
  add_index "recollection_pages", ["recollection_id"], name: "index_recollection_pages_on_recollection_id", using: :btree

  create_table "recollections", force: true do |t|
    t.string   "name"
    t.datetime "date"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "goal"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "recollection"
    t.integer  "project_id"
    t.string   "search"
    t.integer  "state"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.text     "report"
  end

  add_index "recollections", ["project_id"], name: "index_recollections_on_project_id", using: :btree
  add_index "recollections", ["user_id"], name: "index_recollections_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "tags", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
