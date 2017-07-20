class AddCategoryToSlide < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :category, :integer, default: 1, null: false
  end
end
