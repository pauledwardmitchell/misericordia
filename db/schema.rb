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

ActiveRecord::Schema.define(version: 20170824185319) do

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
    t.integer  "og_id"
    t.integer  "security_vendor_id"
    t.integer  "building_id"
    t.integer  "current_month_pay"
    t.integer  "new_month_pay"
    t.string   "new_start_date"
    t.string   "new_end_date"
    t.string   "notes"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "security_vendors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end