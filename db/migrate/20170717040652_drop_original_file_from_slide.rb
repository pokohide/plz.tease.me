class DropOriginalFileFromSlide < ActiveRecord::Migration[5.0]
  def change
    remove_column :slides, :original_file
    add_column :slides, :page_view, :integer, default: 0
  end
end
