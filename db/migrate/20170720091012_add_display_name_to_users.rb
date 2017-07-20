class AddDisplayNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :display_name, :string , default: '', null: false
  end
end
