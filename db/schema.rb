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

ActiveRecord::Schema.define(version: 2021_12_28_162736) do

  create_table "ahoy_events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "visit_id"
    t.string "name"
    t.text "properties", limit: 4294967295, collation: "utf8mb4_bin"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "chats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number", null: false
    t.string "messages_count", default: "0"
    t.string "slug"
    t.bigint "ahoy_visit_id"
    t.bigint "system_application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ahoy_visit_id"], name: "index_chats_on_ahoy_visit_id"
    t.index ["number"], name: "index_chats_on_number"
    t.index ["slug"], name: "index_chats_on_slug"
    t.index ["system_application_id"], name: "index_chats_on_system_application_id"
  end

  create_table "friendly_id_slugs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, length: { slug: 70, scope: 70 }
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", length: { slug: 140 }
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number", null: false
    t.string "slug"
    t.text "body", default: "''"
    t.bigint "ahoy_visit_id"
    t.bigint "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ahoy_visit_id"], name: "index_messages_on_ahoy_visit_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["number"], name: "index_messages_on_number"
    t.index ["slug"], name: "index_messages_on_slug"
  end

  create_table "system_applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "token", null: false
    t.string "chats_count", default: "0"
    t.string "slug"
    t.bigint "ahoy_visit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ahoy_visit_id"], name: "index_system_applications_on_ahoy_visit_id"
    t.index ["slug"], name: "index_system_applications_on_slug"
    t.index ["token"], name: "index_system_applications_on_token"
  end

  add_foreign_key "chats", "system_applications"
  add_foreign_key "messages", "chats"
end
