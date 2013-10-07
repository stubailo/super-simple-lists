class RenameListsUsersToListPermissions < ActiveRecord::Migration
  def change
    rename_table :lists_users, :list_permissions
  end
end
