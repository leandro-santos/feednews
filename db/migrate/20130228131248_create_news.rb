class CreateNews < ActiveRecord::Migration
  def up
    create_table :news do |t|
      t.string :title
      t.text   :description
      t.string :link, null: false
      t.string :author
      t.string :categoryDomain
      t.string :comments
      t.string :enclosureUrl
      t.string :enclosureLength
      t.string :enclosureType
      t.string :guidIsPermaLink
      t.string :pubDate
      t.string :sourceUrl

      t.references :feed

      t.timestamps
    end

    add_index :news, :feed_id
  end

  def down
    drop_table :news
  end
end