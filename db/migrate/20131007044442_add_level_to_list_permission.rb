class AddLevelToListPermission < ActiveRecord::Migration
  def change
    add_column :list_permissions, :level, :string
  end
end
