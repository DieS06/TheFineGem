class RenameTypeForRoom < ActiveRecord::Migration[7.2]
  def change
    rename_column :rooms, :type, :room_type
  end
end
