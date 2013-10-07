class CreateNotesLists < ActiveRecord::Migration
  def change
    create_table :notes_lists do |t|
      t.belongs_to :note
      t.belongs_to :part
      t.timestamps
    end
  end
end
