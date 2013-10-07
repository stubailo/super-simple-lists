class DropListsNotes < ActiveRecord::Migration
  def change
    drop_table :lists_notes
  end
end
