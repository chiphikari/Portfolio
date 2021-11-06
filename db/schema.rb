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

ActiveRecord::Schema.define(version: 2021_11_06_103328) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_summary_id"
    t.datetime "created_at", null: false
    t.datetime "update_at"
    t.datetime "updated_at", null: false
    t.index ["post_summary_id"], name: "index_bookmarks_on_post_summary_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "update_at"
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_summary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_summary_id"], name: "index_favorites_on_post_summary_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "post_houses", force: :cascade do |t|
    t.integer "post_summary_id"
    t.text "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_summary_id"], name: "index_post_houses_on_post_summary_id"
  end

  create_table "post_images", force: :cascade do |t|
    t.string "image_id"
    t.integer "post_summary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_summary_id"], name: "index_post_images_on_post_summary_id"
  end

  create_table "post_outsides", force: :cascade do |t|
    t.integer "post_summary_id"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_summary_id"], name: "index_post_outsides_on_post_summary_id"
  end

  create_table "post_summaries", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_house_id"
    t.integer "post_outside_id"
    t.string "title"
    t.string "headline"
    t.text "introduction"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_house_id"], name: "index_post_summaries_on_post_house_id"
    t.index ["post_outside_id"], name: "index_post_summaries_on_post_outside_id"
    t.index ["user_id"], name: "index_post_summaries_on_user_id"
  end

  create_table "post_tags", force: :cascade do |t|
    t.integer "post_summary_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "update_at"
    t.datetime "updated_at", null: false
    t.index ["post_summary_id"], name: "index_post_tags_on_post_summary_id"
    t.index ["tag_id"], name: "index_post_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name"
    t.datetime "created_at", null: false
    t.datetime "update_at"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "user_name", null: false
    t.string "postal_code", null: false
    t.string "address", null: false
    t.string "profile_image_id"
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
