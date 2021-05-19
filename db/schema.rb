# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_19_151112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_aare", id: :serial, force: :cascade do |t|
    t.datetime "datum", null: false
    t.float "abfluss"
    t.float "pegel"
    t.float "sauerstoffgehalt"
    t.float "temperatur"
  end

  create_table "data_bern_zollikofen", id: :serial, force: :cascade do |t|
    t.integer "jahr", null: false
    t.integer "monat", null: false
    t.float "temperatur", null: false
    t.float "niederschlag", null: false
  end

  create_table "data_kanton", id: :serial, force: :cascade do |t|
    t.text "kuerzel", null: false
    t.text "name", null: false
  end

  create_table "data_luftqualitaet", id: :serial, force: :cascade do |t|
    t.datetime "datum", null: false
    t.text "standort", null: false
    t.text "parameter", null: false
    t.text "einheit", null: false
    t.integer "wert"
  end

  create_table "data_rhein", id: :serial, force: :cascade do |t|
    t.datetime "start", null: false
    t.datetime "ende", null: false
    t.float "elektrische_leitfaehigkeit"
    t.float "sauerstoffgehalt"
    t.float "ph"
    t.float "temperatur"
  end

  create_table "data_sensor_values", force: :cascade do |t|
    t.bigint "data_sensor_id", null: false
    t.float "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data_sensor_id"], name: "index_data_sensor_values_on_data_sensor_id"
  end

  create_table "data_sensors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "data_solar", id: :serial, force: :cascade do |t|
    t.text "gemeinde", null: false
    t.float "scenario1_roofsonly", null: false
    t.float "scenario2_roofsonly", null: false
    t.float "scenario3_roofsfacades", null: false
    t.float "scenario4_roofsfacades", null: false
    t.integer "kanton_id"
  end

  create_table "data_todesfaelle", id: :serial, force: :cascade do |t|
    t.integer "jahr", null: false
    t.integer "kalenderwoche", null: false
    t.text "altersgruppe", null: false
    t.text "geschlecht", null: false
    t.integer "todesfaelle", null: false
    t.integer "kanton_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "page_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_memberships_on_page_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name", null: false
    t.text "css"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "queries", force: :cascade do |t|
    t.bigint "visual_id", null: false
    t.string "query", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["visual_id"], name: "index_queries_on_visual_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visuals", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.string "name"
    t.string "type", null: false
    t.integer "position"
    t.string "klass"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_visuals_on_page_id"
  end

  add_foreign_key "data_sensor_values", "data_sensors"
  add_foreign_key "data_solar", "data_kanton", column: "kanton_id", name: "data_solar_kanton_id_fkey"
  add_foreign_key "data_todesfaelle", "data_kanton", column: "kanton_id", name: "data_todesfaelle_kanton_id_fkey"
  add_foreign_key "memberships", "pages"
  add_foreign_key "memberships", "users"
  add_foreign_key "queries", "visuals"
  add_foreign_key "visuals", "pages"
end
