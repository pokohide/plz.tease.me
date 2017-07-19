class AddNoteToSlide < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :comments_count, :integer, default: 0
    add_column :slides, :likes_count, :integer, default: 0
    add_column :slide_outlines, :note, :text
  end
end
