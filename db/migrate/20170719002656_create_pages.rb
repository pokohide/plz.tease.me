class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :image, null: false
      t.integer :num, null: false
      t.references :slide, foreign_key: true

      t.timestamps
    end
  end
end
