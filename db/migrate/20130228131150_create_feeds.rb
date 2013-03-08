class CreateFeeds < ActiveRecord::Migration
  def up
    create_table :feeds do |t|
      t.string :rssLink
      t.string :xml_version
      t.string :rss_version
      t.string :title, null: false
      t.string :link, null: false
      t.string :description, null: false
      t.string :language
      t.string :copyright
      t.string :managingEditor
      t.string :webMaster
      t.string :pubDate
      t.string :lastBuildDate
      t.string :categories
      t.string :categoryDomain
      t.string :generator
      t.string :docs
      t.string :cloudDomain
      t.string :cloudPort
      t.string :cloudPath
      t.string :cloudRegisterProcedure
      t.string :cloudProtocol
      t.string :ttl
      t.string :imageUrl
      t.string :imageTitle
      t.string :imageLink
      t.string :imageWidth
      t.string :imageHeight
      t.string :rating
      t.string :textInputTitle
      t.string :textInputDescription
      t.string :textInputName
      t.string :textInputLink
      t.string :skipHoursHour
      t.string :skipDaysDay
      t.string :slug

      t.references :category

      t.timestamps
    end

    add_index :feeds, :category_id
    add_index :feeds, :rssLink, unique: true
    add_index :feeds, :title, unique: true
    add_index :feeds, :slug, unique: true
  end

  def down
    drop_table :feeds
  end
end