class AddLastEditorToNote < ActiveRecord::Migration
  def change
    add_column :notes, :last_editor, :string
  end
end
