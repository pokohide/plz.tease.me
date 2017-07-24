class CreateStars < ActiveRecord::Migration[5.0]
  def change
    create_table :stars do |t|
      t.references :user, foreign_key: true
      t.references :slide, foreign_key: true

      t.timestamps
    end

    remove_column :slides, :likes_count
    add_column :slides, :stars_count, :integer, default: 0
  end
end
