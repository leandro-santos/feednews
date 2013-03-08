class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :description, null: false
      t.string :slug

      t.timestamps
    end

    add_index :categories, :description, unique: true
    add_index :categories, :slug, unique: true
  end

  def down
    drop_table :categories
  end
end