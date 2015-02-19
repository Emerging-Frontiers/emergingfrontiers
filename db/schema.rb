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

ActiveRecord::Schema.define(version: 20141218063546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_countries", force: true do |t|
    t.integer "article_id"
    t.integer "country_id"
  end

  add_index "article_countries", ["article_id", "country_id"], name: "index_article_countries_on_article_id_and_country_id", using: :btree

  create_table "article_sectors", force: true do |t|
    t.integer  "article_id"
    t.integer  "sector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_sectors", ["article_id", "sector_id"], name: "index_article_sectors_on_article_id_and_sector_id", using: :btree

  create_table "article_sub_sectors", force: true do |t|
    t.integer "article_id"
    t.integer "sub_sector_id"
  end

  add_index "article_sub_sectors", ["article_id", "sub_sector_id"], name: "index_article_sub_sectors_on_article_id_and_sub_sector_id", using: :btree

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "stub"
    t.text     "content"
    t.text     "summary"
    t.integer  "user_id"
    t.integer  "publisher_id"
    t.string   "status",              default: "draft"
    t.integer  "visits_count",        default: 0
    t.integer  "integer",             default: 0
    t.datetime "published_date"
    t.boolean  "assets_migrated",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "legacy_content"
    t.string   "legacy_guid"
    t.integer  "legacy_publisher_id"
  end

  add_index "articles", ["legacy_publisher_id"], name: "index_articles_on_legacy_publisher_id", using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "blog_attachments", force: true do |t|
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "published",                 default: true
    t.string   "category"
    t.integer  "category_id"
    t.string   "banner_image_file_name"
    t.string   "banner_image_content_type"
    t.integer  "banner_image_file_size"
    t.datetime "banner_image_updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.boolean  "publish",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.string   "legacy_url"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "countries", force: true do |t|
    t.string  "name"
    t.string  "stub"
    t.integer "region_id"
    t.boolean "featured",    default: false
    t.text    "description"
  end

  create_table "feed_sources", force: true do |t|
    t.string  "name"
    t.string  "url"
    t.boolean "active", default: true
  end

  create_table "investors", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "country"
    t.string   "user_name"
    t.boolean  "us_citizen"
    t.boolean  "uk_citizen"
    t.boolean  "not_us_uk_citizen"
    t.string   "us_tax_purpose"
    t.boolean  "us_provision_term"
    t.boolean  "us_terms_of_service"
    t.boolean  "uk_term1"
    t.boolean  "uk_term2"
    t.boolean  "uk_term3"
    t.boolean  "uk_annual_income"
    t.boolean  "uk_assets_worth"
  end

  add_index "investors", ["email"], name: "index_investors_on_email", unique: true, using: :btree
  add_index "investors", ["reset_password_token"], name: "index_investors_on_reset_password_token", unique: true, using: :btree

  create_table "legacy_images", force: true do |t|
    t.integer  "article_id"
    t.text     "legacy_url"
    t.text     "s3_url"
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legacy_images", ["article_id"], name: "index_legacy_images_on_article_id", using: :btree
  add_index "legacy_images", ["legacy_url", "s3_url"], name: "index_legacy_images_on_legacy_url_and_s3_url", using: :btree

  create_table "legacy_terms", force: true do |t|
    t.string   "name"
    t.string   "taxonomy"
    t.string   "description"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legacy_terms", ["article_id"], name: "index_legacy_terms_on_article_id", using: :btree

  create_table "news_items", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "channel"
    t.text     "content"
    t.boolean  "active",         default: true
    t.datetime "published_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_source_id"
  end

  add_index "news_items", ["feed_source_id"], name: "index_news_items_on_feed_source_id", using: :btree
  add_index "news_items", ["url"], name: "index_news_items_on_url", using: :btree

  create_table "page_fragments", force: true do |t|
    t.string   "name"
    t.string   "stub"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "stub"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "service_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "partners", ["country_id"], name: "index_partners_on_country_id", using: :btree
  add_index "partners", ["service_id"], name: "index_partners_on_service_id", using: :btree

  create_table "regions", force: true do |t|
    t.string "name"
    t.string "stub"
    t.text   "description"
  end

  create_table "sectors", force: true do |t|
    t.string  "name"
    t.string  "stub"
    t.boolean "featured"
    t.string  "short_name"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_pages", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_sectors", force: true do |t|
    t.string  "name"
    t.string  "stub"
    t.integer "sector_id"
  end

  add_index "sub_sectors", ["sector_id"], name: "index_sub_sectors_on_sector_id", using: :btree

  create_table "subscribers", force: true do |t|
    t.string   "email"
    t.string   "interests"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "sector_id"
    t.integer  "subscriber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                   default: "guest"
    t.string   "legacy_user_login"
    t.string   "display_name"
    t.integer  "legacy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
