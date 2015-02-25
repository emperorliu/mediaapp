class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :media_items, :type, :medium
  end
end
