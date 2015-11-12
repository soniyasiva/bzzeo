# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151112210058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "post_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["profile_id"], name: "index_comments_on_profile_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.text     "message"
    t.boolean  "read"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "friends", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "friend_id"
    t.boolean  "mutual"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "friends", ["profile_id"], name: "index_friends_on_profile_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["post_id"], name: "index_likes_on_post_id", using: :btree
  add_index "likes", ["profile_id"], name: "index_likes_on_profile_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.text     "html"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "partners", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "partner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "partners", ["profile_id"], name: "index_partners_on_profile_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "image_url"
    t.string   "video_url"
    t.text     "description"
    t.integer  "profile_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "thumbnail_url"
  end

  add_index "posts", ["profile_id"], name: "index_posts_on_profile_id", using: :btree

  create_table "profile_tags", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "profile_tags", ["profile_id"], name: "index_profile_tags_on_profile_id", using: :btree
  add_index "profile_tags", ["tag_id"], name: "index_profile_tags_on_tag_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "video_url"
    t.string   "representitive"
    t.string   "phone"
    t.string   "status"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instagram"
    t.string   "address"
    t.float    "lat"
    t.float    "lng"
    t.string   "thumbnail_url"
  end

  add_index "profiles", ["category_id"], name: "index_profiles_on_category_id", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "shares", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "shares", ["post_id"], name: "index_shares_on_post_id", using: :btree
  add_index "shares", ["profile_id"], name: "index_shares_on_profile_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "profiles"
  add_foreign_key "friends", "profiles"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "profiles"
  add_foreign_key "partners", "profiles"
  add_foreign_key "posts", "profiles"
  add_foreign_key "profile_tags", "profiles"
  add_foreign_key "profile_tags", "tags"
  add_foreign_key "profiles", "categories"
  add_foreign_key "profiles", "users"
  add_foreign_key "shares", "posts"
  add_foreign_key "shares", "profiles"
end
