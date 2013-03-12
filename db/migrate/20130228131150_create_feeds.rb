class CreateFeeds < ActiveRecord::Migration
  def up
    create_table :feeds do |t|
      t.string :rss_link
      t.string :xml_version
      t.string :rss_version
      t.string :title, null: false
      t.string :link, null: false
      t.string :description, null: false
      t.string :language
      t.string :copyright
      t.string :managing_editor
      t.string :web_master
      t.string :pub_date
      t.string :last_build_date
      t.string :categories
      t.string :category_domain
      t.string :generator
      t.string :docs
      t.string :cloud_domain
      t.string :cloud_port
      t.string :cloud_path
      t.string :cloud_register_procedure
      t.string :cloud_protocol
      t.string :ttl
      t.string :image_url
      t.string :image_title
      t.string :image_link
      t.string :image_width
      t.string :image_height
      t.string :rating
      t.string :text_input_title
      t.string :text_input_description
      t.string :text_input_name
      t.string :text_input_link
      t.string :skip_hours_hour
      t.string :skip_days_day
      t.string :slug

      t.references :category

      t.timestamps
    end

    add_index :feeds, :category_id
    add_index :feeds, :rss_link, unique: true
    #add_index :feeds, :title, unique: true
    add_index :feeds, :slug, unique: true
  end

  def down
    drop_table :feeds
  end
end