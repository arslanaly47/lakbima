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

ActiveRecord::Schema.define(version: 20170131004532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_main_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "account_sub_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "account_main_type_id"
    t.text     "description"
    t.index ["account_main_type_id"], name: "index_account_sub_types_on_account_main_type_id", using: :btree
  end

  create_table "account_types", force: :cascade do |t|
    t.integer  "account_sub_type_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["account_sub_type_id"], name: "index_account_types_on_account_sub_type_id", using: :btree
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "account_type_id"
    t.decimal  "opening_balance",       precision: 8, scale: 2
    t.decimal  "transactional_balance", precision: 8, scale: 2, default: "0.0"
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id", using: :btree
  end

  create_table "allowance_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "lump_sum_amount"
    t.integer  "currency_id"
    t.index ["currency_id"], name: "index_allowance_types_on_currency_id", using: :btree
  end

  create_table "allowances", force: :cascade do |t|
    t.integer  "allowance_type_id"
    t.integer  "salary_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.date     "starts_from"
    t.date     "ends_at"
    t.index ["allowance_type_id"], name: "index_allowances_on_allowance_type_id", using: :btree
    t.index ["salary_id"], name: "index_allowances_on_salary_id", using: :btree
  end

  create_table "attachment_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.boolean  "verified"
    t.integer  "attachment_type_id"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id", using: :btree
    t.index ["attachment_type_id"], name: "index_attachments_on_attachment_type_id", using: :btree
  end

  create_table "branches", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "business_name"
    t.string   "other_names"
    t.text     "address"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "commercial_registration_no"
    t.date     "commercial_registration_expiry"
    t.string   "municipality_registration_no"
    t.date     "municipality_registration_expiry"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "subdomain"
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "symbol"
    t.string   "country"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "default",    default: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dynamic_menus", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dynamic_menus_from_account_types", id: false, force: :cascade do |t|
    t.integer "dynamic_menu_id"
    t.integer "account_type_id"
    t.index ["account_type_id"], name: "index_dynamic_menus_from_account_types_on_account_type_id", using: :btree
    t.index ["dynamic_menu_id"], name: "index_dynamic_menus_from_account_types_on_dynamic_menu_id", using: :btree
  end

  create_table "dynamic_menus_to_account_types", force: :cascade do |t|
    t.integer "dynamic_menu_id"
    t.integer "account_type_id"
    t.index ["account_type_id"], name: "index_dynamic_menus_to_account_types_on_account_type_id", using: :btree
    t.index ["dynamic_menu_id"], name: "index_dynamic_menus_to_account_types_on_dynamic_menu_id", using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "address"
    t.string   "phone_number"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "nationality"
    t.string   "passport_no"
    t.date     "passport_expiry"
    t.string   "visa_no"
    t.string   "id_no"
    t.date     "visa_expiry"
    t.date     "medical_expiry"
    t.date     "date_of_joining"
    t.integer  "job_title_id"
    t.date     "appointment_date"
    t.integer  "user_id"
    t.integer  "branch_id"
    t.boolean  "terminated",       default: false
    t.boolean  "future",           default: false
    t.index ["branch_id"], name: "index_employees_on_branch_id", using: :btree
    t.index ["job_title_id"], name: "index_employees_on_job_title_id", using: :btree
    t.index ["terminated"], name: "index_employees_on_terminated", using: :btree
    t.index ["user_id"], name: "index_employees_on_user_id", using: :btree
  end

  create_table "job_titles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_job_titles_on_department_id", using: :btree
  end

  create_table "journal_entries", force: :cascade do |t|
    t.integer  "journal_entry_session_id"
    t.date     "happened_at"
    t.decimal  "amount",                   precision: 8, scale: 2
    t.text     "description"
    t.integer  "from_account_id"
    t.integer  "to_account_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["from_account_id"], name: "index_journal_entries_on_from_account_id", using: :btree
    t.index ["journal_entry_session_id"], name: "index_journal_entries_on_journal_entry_session_id", using: :btree
    t.index ["to_account_id"], name: "index_journal_entries_on_to_account_id", using: :btree
  end

  create_table "journal_entry_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_journal_entry_sessions_on_user_id", using: :btree
  end

  create_table "leave_applications", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "reason"
    t.integer  "number_of_days"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "manager_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "status",           default: 0
    t.integer  "vacation_type_id"
    t.index ["manager_id"], name: "index_leave_applications_on_manager_id", using: :btree
    t.index ["user_id"], name: "index_leave_applications_on_user_id", using: :btree
    t.index ["vacation_type_id"], name: "index_leave_applications_on_vacation_type_id", using: :btree
  end

  create_table "notification_users", force: :cascade do |t|
    t.integer  "notification_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["notification_id"], name: "index_notification_users_on_notification_id", using: :btree
    t.index ["user_id"], name: "index_notification_users_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "leave_application_id"
    t.integer  "notification_type"
    t.index ["leave_application_id"], name: "index_notifications_on_leave_application_id", using: :btree
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

  create_table "salaries", force: :cascade do |t|
    t.integer  "employee_id"
    t.decimal  "basic_salary", precision: 10, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["employee_id"], name: "index_salaries_on_employee_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "from_account_id"
    t.integer  "to_account_id"
    t.integer  "dynamic_menu_id"
    t.decimal  "amount",          precision: 8, scale: 2
    t.date     "happened_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.text     "description"
    t.integer  "user_id"
    t.index ["dynamic_menu_id"], name: "index_transactions_on_dynamic_menu_id", using: :btree
    t.index ["user_id"], name: "index_transactions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "phone_number"
    t.text     "address"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "role_id"
    t.string   "temp_password"
    t.boolean  "temp_password_changed",  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  create_table "vacation_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "vacations", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "vacation_type_id"
    t.date     "starts_from"
    t.date     "ends_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["employee_id"], name: "index_vacations_on_employee_id", using: :btree
    t.index ["vacation_type_id"], name: "index_vacations_on_vacation_type_id", using: :btree
  end

  add_foreign_key "account_sub_types", "account_main_types"
  add_foreign_key "account_types", "account_sub_types"
  add_foreign_key "allowance_types", "currencies"
  add_foreign_key "allowances", "allowance_types"
  add_foreign_key "allowances", "salaries"
  add_foreign_key "attachments", "attachment_types"
  add_foreign_key "dynamic_menus_from_account_types", "account_types"
  add_foreign_key "dynamic_menus_from_account_types", "dynamic_menus"
  add_foreign_key "dynamic_menus_to_account_types", "account_types"
  add_foreign_key "dynamic_menus_to_account_types", "dynamic_menus"
  add_foreign_key "employees", "job_titles"
  add_foreign_key "employees", "users"
  add_foreign_key "job_titles", "departments"
  add_foreign_key "journal_entries", "journal_entry_sessions"
  add_foreign_key "journal_entry_sessions", "users"
  add_foreign_key "leave_applications", "users"
  add_foreign_key "leave_applications", "vacation_types"
  add_foreign_key "notification_users", "notifications"
  add_foreign_key "notification_users", "users"
  add_foreign_key "notifications", "leave_applications"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "salaries", "employees"
  add_foreign_key "transactions", "dynamic_menus"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "roles"
  add_foreign_key "vacations", "employees"
  add_foreign_key "vacations", "vacation_types"
end
