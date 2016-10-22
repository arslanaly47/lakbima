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

ActiveRecord::Schema.define(version: 20161022111058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowance_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "percentage_of_basic_salary", precision: 4, scale: 1
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "symbol"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "address"
    t.string   "phone_number"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "username"
    t.string   "nationality"
    t.string   "passport_no"
    t.date     "passport_expiry"
    t.string   "visa_no"
    t.string   "id_no"
    t.date     "visa_expiry"
    t.date     "medical_expiry"
    t.string   "job_title"
    t.decimal  "basic_salary",    precision: 10, scale: 2
    t.decimal  "fixed_allowance", precision: 8,  scale: 2
    t.date     "date_of_joining"
  end

  create_table "job_titles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_job_titles_on_department_id", using: :btree
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "subject_class"
    t.string   "action"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "permissions_roles", force: :cascade do |t|
    t.integer "role_id"
    t.integer "permission_id"
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id", using: :btree
    t.index ["role_id"], name: "index_permissions_roles_on_role_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "phone_number"
    t.text     "address"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  add_foreign_key "job_titles", "departments"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "users", "roles"
end
