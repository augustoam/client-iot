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

ActiveRecord::Schema.define(version: 20171012232624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "ambientes", force: :cascade do |t|
    t.string "nome"
    t.integer "grupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comandos_infra_vermelhos", force: :cascade do |t|
    t.integer "componente_id"
    t.string "topico"
    t.string "comando"
    t.string "html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "componentes", force: :cascade do |t|
    t.string "descricao"
    t.string "topico"
    t.integer "ambiente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "estado"
    t.integer "controle_componente_id"
    t.boolean "comando_unico", default: false
  end

  create_table "controles_componentes", force: :cascade do |t|
    t.string "descricao"
    t.text "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grupos", force: :cascade do |t|
    t.string "nome"
    t.boolean "ativo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grupos_usuarios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "grupo_id"
    t.integer "usuario_id"
  end

  create_table "log_componentes", force: :cascade do |t|
    t.integer "grupo_id"
    t.integer "usuario_id"
    t.integer "componente_id"
    t.string "comando"
    t.datetime "dt_criacao", default: "2017-10-12 23:45:48"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  add_foreign_key "ambientes", "grupos"
  add_foreign_key "comandos_infra_vermelhos", "componentes"
  add_foreign_key "componentes", "ambientes"
  add_foreign_key "componentes", "controles_componentes"
  add_foreign_key "grupos_usuarios", "grupos"
  add_foreign_key "grupos_usuarios", "usuarios"
end
