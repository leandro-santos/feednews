class CreateNews < ActiveRecord::Migration
  def up
    create_table :news do |t|
      t.string :title
      t.text   :description
      t.string :link, null: false
      t.string :author
      t.string :category_domain
      t.string :comments
      t.string :enclosure_url
      t.string :enclosure_length
      t.string :enclosure_type
      t.string :guid_is_perma_link
      t.datetime :pub_date
      t.string :source_url
      t.string :slug

      t.references :feed

      t.timestamps
    end

    add_index :news, :feed_id
    add_index :news, :slug, unique: true
  end

  def down
    drop_table :news
  end
end