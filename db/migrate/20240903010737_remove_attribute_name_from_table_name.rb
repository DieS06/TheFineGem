class RemoveAttributeNameFromTableName < ActiveRecord::Migration[7.2]
  def change
    remove_column :rooms, :price_range, :string
  end
end
