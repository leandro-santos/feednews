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
      t.string :pub_date
      t.string :source_url

      t.references :feed

      t.timestamps
    end

    add_index :news, :feed_id
  end

  def down
    drop_table :news
  end
end