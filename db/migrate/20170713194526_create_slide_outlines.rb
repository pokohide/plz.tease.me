class CreateSlideOutlines < ActiveRecord::Migration[5.0]
  def change
    create_table :slide_outlines do |t|
      t.references :slide, foreign_key: true
      t.text       :body, limit: 16.megabyte - 1 # mediumtext

      t.timestamps null: false
    end
  end
end
