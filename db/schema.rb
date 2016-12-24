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

ActiveRecord::Schema.define(version: 20161223153041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annonces", force: :cascade do |t|
    t.string   "name"
    t.string   "avatar"
    t.date     "experience"
    t.text     "description"
    t.string   "type"
    t.string   "style"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_annonces_on_user_id", using: :btree
  end

  create_table "availabilities", force: :cascade do |t|
    t.integer  "annonce_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["annonce_id"], name: "index_availabilities_on_annonce_id", using: :btree
  end

  create_table "demandes", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "prix"
    t.integer  "statut"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.integer  "annonce_id"
    t.index ["annonce_id"], name: "index_demandes_on_annonce_id", using: :btree
    t.index ["user_id"], name: "index_demandes_on_user_id", using: :btree
  end

  create_table "establishments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.json     "pictures"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_establishments_on_user_id", using: :btree
  end

  create_table "groupes", force: :cascade do |t|
    t.string   "name",             default: "", null: false
    t.integer  "user_id"
    t.string   "genre"
    t.date     "date_de_creation"
    t.text     "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "avatar"
    t.index ["user_id"], name: "index_groupes_on_user_id", using: :btree
  end

  create_table "histo_demandes", force: :cascade do |t|
    t.integer  "demande_id"
    t.integer  "user_id"
    t.integer  "groupe_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "prix"
    t.integer  "statut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["demande_id"], name: "index_histo_demandes_on_demande_id", using: :btree
    t.index ["groupe_id"], name: "index_histo_demandes_on_groupe_id", using: :btree
    t.index ["user_id"], name: "index_histo_demandes_on_user_id", using: :btree
  end

  create_table "materiels", force: :cascade do |t|
    t.string "libelle"
  end

  create_table "membres", force: :cascade do |t|
    t.string   "nom"
    t.string   "instrument"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "annonce_id"
    t.index ["annonce_id"], name: "index_membres_on_annonce_id", using: :btree
  end

  create_table "previews", force: :cascade do |t|
    t.integer  "type"
    t.string   "file"
    t.integer  "annonce_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["annonce_id"], name: "index_previews_on_annonce_id", using: :btree
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "nom"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "utilises", force: :cascade do |t|
    t.integer "materiel_id"
    t.integer "quantite"
    t.integer "annonce_id"
    t.index ["annonce_id"], name: "index_utilises_on_annonce_id", using: :btree
    t.index ["materiel_id"], name: "index_utilises_on_materiel_id", using: :btree
  end

  add_foreign_key "annonces", "users"
  add_foreign_key "availabilities", "annonces"
  add_foreign_key "demandes", "annonces"
  add_foreign_key "demandes", "users"
  add_foreign_key "establishments", "users"
  add_foreign_key "groupes", "users"
  add_foreign_key "histo_demandes", "demandes"
  add_foreign_key "histo_demandes", "groupes"
  add_foreign_key "histo_demandes", "users"
  add_foreign_key "membres", "annonces"
  add_foreign_key "previews", "annonces"
  add_foreign_key "utilises", "annonces"
  add_foreign_key "utilises", "materiels"
end
