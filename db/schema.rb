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
    t.string   "rssLink"
    t.string   "xml_version"
    t.string   "rss_version"
    t.string   "title",                  :null => false
    t.string   "link",                   :null => false
    t.string   "description",            :null => false
    t.string   "language"
    t.string   "copyright"
    t.string   "managingEditor"
    t.string   "webMaster"
    t.string   "pubDate"
    t.string   "lastBuildDate"
    t.string   "categories"
    t.string   "categoryDomain"
    t.string   "generator"
    t.string   "docs"
    t.string   "cloudDomain"
    t.string   "cloudPort"
    t.string   "cloudPath"
    t.string   "cloudRegisterProcedure"
    t.string   "cloudProtocol"
    t.string   "ttl"
    t.string   "imageUrl"
    t.string   "imageTitle"
    t.string   "imageLink"
    t.string   "imageWidth"
    t.string   "imageHeight"
    t.string   "rating"
    t.string   "textInputTitle"
    t.string   "textInputDescription"
    t.string   "textInputName"
    t.string   "textInputLink"
    t.string   "skipHoursHour"
    t.string   "skipDaysDay"
    t.string   "slug"
    t.integer  "category_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "feeds", ["category_id"], :name => "index_feeds_on_category_id"
  add_index "feeds", ["rssLink"], :name => "index_feeds_on_rssLink", :unique => true
  add_index "feeds", ["slug"], :name => "index_feeds_on_slug", :unique => true
  add_index "feeds", ["title"], :name => "index_feeds_on_title", :unique => true

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link",            :null => false
    t.string   "author"
    t.string   "categoryDomain"
    t.string   "comments"
    t.string   "enclosureUrl"
    t.string   "enclosureLength"
    t.string   "enclosureType"
    t.string   "guidIsPermaLink"
    t.string   "pubDate"
    t.string   "sourceUrl"
    t.integer  "feed_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "news", ["feed_id"], :name => "index_news_on_feed_id"

end
