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

ActiveRecord::Schema.define(version: 20170104024354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "service_integrations", force: :cascade do |t|
    t.string   "service_name"
    t.string   "service_authorization_url"
    t.string   "service_base_api_url"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "encrypted_client_app_id"
    t.string   "encrypted_client_app_id_iv"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "encrypted_preferred_units"
    t.string   "encrypted_preferred_units_iv"
    t.string   "encrypted_height"
    t.string   "encrypted_gender_iv"
    t.string   "encrypted_full_name"
    t.string   "encrypted_full_name_iv"
    t.string   "encrypted_height_iv"
    t.string   "preferred_timezone"
    t.index ["user_id"], name: "index_user_profiles_on_user_id", using: :btree
  end

  create_table "user_service_integrations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "service_integration_id"
    t.string   "encrypted_authorization_token"
    t.string   "encrypted_authorization_token_iv"
    t.string   "encrypted_access_token"
    t.string   "encrypted_access_token_iv"
    t.string   "encrypted_refresh_token"
    t.string   "encrypted_refresh_token_iv"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["service_integration_id"], name: "index_user_service_integrations_on_service_integration_id", using: :btree
    t.index ["user_id"], name: "index_user_service_integrations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "weight_entries", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "encrypted_exact_weight"
    t.string   "encrypted_exact_weight_iv"
    t.string   "encrypted_bmi"
    t.string   "encrypted_bmi_iv"
    t.index ["user_id"], name: "index_weight_entries_on_user_id", using: :btree
  end

  add_foreign_key "user_profiles", "users"
  add_foreign_key "user_service_integrations", "service_integrations"
  add_foreign_key "user_service_integrations", "users"
  add_foreign_key "weight_entries", "users"
end
