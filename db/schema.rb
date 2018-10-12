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

ActiveRecord::Schema.define(version: 20180916132031) do

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
    t.string "descricao"
    t.string "icone"
    t.string "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ambientes_grupo", force: :cascade do |t|
    t.string "nome"
    t.integer "grupo_id"
    t.integer "ambiente_id"
    t.string "icone"
    t.boolean "visivel", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comandos_infra_vermelhos", force: :cascade do |t|
    t.integer "controle_id"
    t.string "comando"
    t.string "codigo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "componentes", force: :cascade do |t|
    t.string "descricao"
    t.string "modelo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "comando_unico", default: false
  end

  create_table "componentes_ambiente", force: :cascade do |t|
    t.integer "ambiente_grupo_id"
    t.string "topico"
    t.string "valor"
    t.boolean "estado", default: false
    t.text "descricao"
    t.text "identificador_componente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "controle_id"
  end

  create_table "controles", force: :cascade do |t|
    t.string "descricao"
    t.text "obs"
    t.integer "fabricante_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "layout_controle_id"
    t.integer "componente_id"
  end

  create_table "fabricantes", force: :cascade do |t|
    t.string "descricao"
    t.string "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grupos", force: :cascade do |t|
    t.string "nome"
    t.boolean "ativo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grupos_usuarios", force: :cascade do |t|
    t.integer "grupo_id"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
  end

  create_table "layout_controles", force: :cascade do |t|
    t.string "descricao"
    t.string "obs"
    t.string "tipo_layout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_componentes", force: :cascade do |t|
    t.integer "grupo_id"
    t.integer "usuario_id"
    t.integer "componente_id"
    t.string "comando"
    t.datetime "dt_criacao", default: "2018-10-02 03:57:25"
  end

  create_table "tokens_notificacao_mobile", force: :cascade do |t|
    t.string "token"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.index ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  add_foreign_key "ambientes_grupo", "ambientes"
  add_foreign_key "ambientes_grupo", "grupos"
  add_foreign_key "comandos_infra_vermelhos", "controles"
  add_foreign_key "componentes_ambiente", "ambientes_grupo"
  add_foreign_key "componentes_ambiente", "controles"
  add_foreign_key "controles", "componentes"
  add_foreign_key "controles", "fabricantes"
  add_foreign_key "controles", "layout_controles"
  add_foreign_key "grupos_usuarios", "grupos"
  add_foreign_key "grupos_usuarios", "usuarios"
  add_foreign_key "tokens_notificacao_mobile", "usuarios"
end
