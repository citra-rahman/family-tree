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

ActiveRecord::Schema[8.0].define(version: 2024_11_13_153124) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "families", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.string "gender", null: false
    t.datetime "birth_date", null: false
    t.datetime "death_date"
    t.bigint "family_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_members_on_family_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "member1_id", null: false
    t.bigint "member2_id", null: false
    t.string "types", null: false
    t.integer "depth", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member1_id"], name: "index_relationships_on_member1_id"
    t.index ["member2_id"], name: "index_relationships_on_member2_id"
  end

  add_foreign_key "members", "families"
  add_foreign_key "relationships", "members", column: "member1_id"
  add_foreign_key "relationships", "members", column: "member2_id"
end
