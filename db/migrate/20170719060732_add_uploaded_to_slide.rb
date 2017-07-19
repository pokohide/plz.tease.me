class AddUploadedToSlide < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :uploaded, :boolean, default: false
  end
end
