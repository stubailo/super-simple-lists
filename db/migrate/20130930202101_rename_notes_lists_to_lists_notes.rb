class RenameNotesListsToListsNotes < ActiveRecord::Migration
  def change
    rename_table :notes_lists, :lists_notes
  end
end
