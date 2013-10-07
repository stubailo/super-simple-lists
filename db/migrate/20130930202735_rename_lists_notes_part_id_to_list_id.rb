class RenameListsNotesPartIdToListId < ActiveRecord::Migration
  def change
      rename_column :lists_notes, :part_id, :list_id
  end
end
