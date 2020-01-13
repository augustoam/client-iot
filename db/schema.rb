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

ActiveRecord::Schema.define(version: 20190114225332) do

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

  create_table "control_commands", force: :cascade do |t|
    t.integer "control_id"
    t.string "command"
    t.string "code"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "control_layouts", force: :cascade do |t|
    t.string "name", limit: 255
    t.text "obs"
    t.string "type"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controls", force: :cascade do |t|
    t.string "name", limit: 255
    t.text "obs"
    t.integer "manufacturer_id"
    t.integer "control_layout_id"
    t.integer "device_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "model", limit: 255
    t.string "url_icon"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_rooms", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "group_id"
    t.integer "room_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", limit: 255
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name", limit: 255
    t.text "obs"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_tokens", force: :cascade do |t|
    t.string "token"
    t.integer "user_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_devices", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "room_id"
    t.integer "device_id"
    t.string "topic_id"
    t.string "sensor_value"
    t.boolean "power"
    t.boolean "online"
    t.string "result"
    t.string "state"
    t.string "info1"
    t.string "info2"
    t.string "info3"
    t.string "topic_info1"
    t.string "topic_info2"
    t.string "topic_info3"
    t.string "topic_power"
    t.string "topic_online"
    t.string "topic_result"
    t.string "topic_publish"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "obs"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_automation_actions", force: :cascade do |t|
    t.integer "type"
    t.decimal "delay_time"
    t.integer "run_automation_id"
    t.integer "user_automation_id"
    t.integer "turn_on_off_automation_id"
    t.integer "room_device_id"
    t.integer "control_command_id"
    t.boolean "turn_on_off"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_automation_conditions", force: :cascade do |t|
    t.integer "user_automation_id"
    t.integer "repeat"
    t.integer "type"
    t.integer "room_device_id"
    t.integer "control_command_id"
    t.datetime "turn_on"
    t.string "value_set"
    t.string "schedule_cron"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_automations", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "condition_operator"
    t.string "name", limit: 255
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "control_commands", "controls"
  add_foreign_key "controls", "control_layouts"
  add_foreign_key "controls", "devices"
  add_foreign_key "controls", "manufacturers"
  add_foreign_key "group_rooms", "groups"
  add_foreign_key "group_rooms", "rooms"
  add_foreign_key "notification_tokens", "users"
  add_foreign_key "room_devices", "devices"
  add_foreign_key "room_devices", "rooms"
  add_foreign_key "user_automation_actions", "control_commands"
  add_foreign_key "user_automation_actions", "room_devices"
  add_foreign_key "user_automation_actions", "user_automations"
  add_foreign_key "user_automation_actions", "user_automations", column: "run_automation_id"
  add_foreign_key "user_automation_actions", "user_automations", column: "turn_on_off_automation_id"
  add_foreign_key "user_automation_conditions", "control_commands"
  add_foreign_key "user_automation_conditions", "room_devices"
  add_foreign_key "user_automation_conditions", "user_automations"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
