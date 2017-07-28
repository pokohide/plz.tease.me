class DropTableStatistics < ActiveRecord::Migration[5.0]
  def change
    drop_table :statistics
  end
end
