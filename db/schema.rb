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

ActiveRecord::Schema.define(version: 20171201200644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.integer  "og_id"
    t.string   "primary_building"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "square_footage"
    t.integer  "organization_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "cleaning_contracts", force: :cascade do |t|
    t.string   "name"
    t.integer  "pw_organization_id"
    t.integer  "building_id"
    t.float    "old_monthly_payment"
    t.float    "cpa_monthly_payment"
    t.date     "contract_start_date"
    t.date     "contract_end_date"
    t.integer  "qbo_customer_id"
    t.float    "rebate_percentage"
    t.boolean  "cover_sheet_entered", default: false
    t.boolean  "invoices_generated",  default: false
    t.boolean  "active",              default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "communicators", force: :cascade do |t|
    t.integer  "og_id"
    t.integer  "organization_id"
    t.integer  "contact_id"
    t.string   "type"
    t.string   "role"
    t.string   "committee_name"
    t.string   "date_noted"
    t.string   "date_term_ends"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "og_id"
    t.string   "salutation"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "level"
    t.string   "email"
    t.string   "frequency"
    t.string   "cell_phone"
    t.string   "office_phone"
    t.string   "fax"
    t.string   "date_of_contact"
    t.string   "cpa_contact"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "copier_contracts", force: :cascade do |t|
    t.string   "name"
    t.integer  "pw_organization_id"
    t.integer  "estimated_savings"
    t.date     "scorecard_start_date"
    t.date     "scorecard_end_date"
    t.date     "invoice_date"
    t.integer  "qbo_customer_id"
    t.boolean  "cover_sheet_entered",  default: false
    t.boolean  "invoices_generated",   default: false
    t.boolean  "active",               default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "qbo_id"
    t.string   "display_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "electricity_contracts", force: :cascade do |t|
    t.string   "name"
    t.integer  "pw_organization_id"
    t.integer  "building_id"
    t.integer  "annual_kwh"
    t.float    "price_to_compare"
    t.float    "cpa_negotiated_price"
    t.date     "contract_start_date"
    t.date     "contract_end_date"
    t.integer  "qbo_customer_id"
    t.float    "rebate_to_cpa"
    t.float    "rebate_to_broker"
    t.float    "estimated_savings"
    t.integer  "ldc_id"
    t.integer  "total_kwh_expected"
    t.boolean  "cover_sheet_entered",  default: false
    t.boolean  "invoices_generated",   default: false
    t.boolean  "active",               default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "gas_contracts", force: :cascade do |t|
    t.string   "name"
    t.integer  "pw_organization_id"
    t.integer  "annual_therms"
    t.float    "price_to_compare"
    t.float    "cpa_negotiated_price"
    t.date     "contract_start_date"
    t.date     "contract_end_date"
    t.integer  "qbo_customer_id"
    t.float    "rebate_to_cpa"
    t.float    "rebate_to_broker"
    t.float    "estimated_savings"
    t.integer  "ldc_id"
    t.integer  "total_therms_expected"
    t.string   "supplier"
    t.boolean  "cover_sheet_entered",   default: false
    t.boolean  "invoices_generated",    default: false
    t.boolean  "active",                default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "landscaping_contracts", force: :cascade do |t|
    t.integer  "pw_organization_id"
    t.integer  "building_id"
    t.float    "old_annual_payment"
    t.float    "cpa_annual_payment"
    t.date     "contract_start_date"
    t.date     "contract_end_date"
    t.integer  "qbo_customer_id"
    t.float    "rebate_percentage"
    t.datetime "billing_start_date"
    t.datetime "billing_end_date"
    t.boolean  "cover_sheet_entered", default: false
    t.boolean  "invoices_generated",  default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.boolean  "active",              default: true
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "contact_id"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.integer  "og_id"
    t.string   "legal_name"
    t.string   "common_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "qbos", force: :cascade do |t|
    t.string   "access_token"
    t.string   "realm_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "og_id"
    t.integer  "organization_id"
    t.integer  "contact_id"
    t.string   "type"
    t.string   "role"
    t.string   "committee_name"
    t.string   "date_noted"
    t.string   "date_term_ends"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "security_contracts", force: :cascade do |t|
    t.string   "name"
    t.integer  "pw_organization_id"
    t.integer  "building_id"
    t.float    "old_monthly_payment"
    t.float    "cpa_monthly_payment"
    t.date     "contract_start_date"
    t.date     "contract_end_date"
    t.integer  "qbo_customer_id"
    t.float    "rebate_percentage"
    t.boolean  "cover_sheet_entered", default: false
    t.boolean  "invoices_generated",  default: false
    t.boolean  "active",              default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "security_vendors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solar_contracts", force: :cascade do |t|
    t.string   "name"
    t.integer  "pw_organization_id"
    t.integer  "estimated_savings"
    t.date     "scorecard_start_date"
    t.date     "scorecard_end_date"
    t.integer  "qbo_customer_id"
    t.boolean  "cover_sheet_entered",  default: false
    t.boolean  "invoices_generated",   default: false
    t.boolean  "active",               default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
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

  create_table "waste_contracts", force: :cascade do |t|
    t.string   "name"
    t.integer  "pw_organization_id"
    t.integer  "building_id"
    t.float    "old_monthly_payment"
    t.float    "cpa_monthly_payment"
    t.date     "contract_start_date"
    t.date     "contract_end_date"
    t.integer  "qbo_customer_id"
    t.float    "rebate_percentage"
    t.boolean  "cover_sheet_entered", default: false
    t.boolean  "invoices_generated",  default: false
    t.boolean  "active",              default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

end
