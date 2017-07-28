class CreateStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :statistics do |t|
      t.references :slide, foreign_key: true
      t.integer :download_count, default: 0
      t.integer :embed_view, default: 0
      t.integer :share_count, default: 0

      t.timestamps
    end
  end
end
