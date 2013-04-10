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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130228131248) do

  create_table "categories", :force => true do |t|
    t.string   "description", :null => false
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categories", ["description"], :name => "index_categories_on_description", :unique => true
  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "feeds", :force => true do |t|
    t.string   "rss_link"
    t.string   "xml_version"
    t.string   "rss_version"
    t.string   "title",                    :null => false
    t.string   "link",                     :null => false
    t.string   "description",              :null => false
    t.string   "language"
    t.string   "copyright"
    t.string   "managing_editor"
    t.string   "web_master"
    t.datetime "pub_date"
    t.datetime "last_build_date"
    t.string   "categories"
    t.string   "category_domain"
    t.string   "generator"
    t.string   "docs"
    t.string   "cloud_domain"
    t.string   "cloud_port"
    t.string   "cloud_path"
    t.string   "cloud_register_procedure"
    t.string   "cloud_protocol"
    t.string   "ttl"
    t.string   "image_url"
    t.string   "image_title"
    t.string   "image_link"
    t.string   "image_width"
    t.string   "image_height"
    t.string   "rating"
    t.string   "text_input_title"
    t.string   "text_input_description"
    t.string   "text_input_name"
    t.string   "text_input_link"
    t.string   "skip_hours_hour"
    t.string   "skip_days_day"
    t.string   "slug"
    t.integer  "category_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "feeds", ["category_id"], :name => "index_feeds_on_category_id"
  add_index "feeds", ["rss_link"], :name => "index_feeds_on_rss_link", :unique => true
  add_index "feeds", ["slug"], :name => "index_feeds_on_slug", :unique => true

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link",               :null => false
    t.string   "author"
    t.string   "category_domain"
    t.string   "comments"
    t.string   "enclosure_url"
    t.string   "enclosure_length"
    t.string   "enclosure_type"
    t.string   "guid_is_perma_link"
    t.datetime "pub_date"
    t.string   "source_url"
    t.string   "slug"
    t.integer  "feed_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "news", ["feed_id"], :name => "index_news_on_feed_id"
  add_index "news", ["slug"], :name => "index_news_on_slug", :unique => true

end
