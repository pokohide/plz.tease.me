class CreateSlides < ActiveRecord::Migration[5.0]
  def change
    create_table :slides do |t|

      t.integer :user_id, null: false
      t.string :title, length: 255
      t.string :slug, length: 255
      t.boolean :is_public, default: false, null: false
      t.string :original_file, length: 255
      t.string :pdf_file, length: 255
      t.string :image_file, length: 255
      t.datetime :published_at

      t.timestamps null: false
    end

    add_index :slides, [:user_id]
  end
end
