class AddListIdToNote < ActiveRecord::Migration
  def change
    add_column :notes, :list_id, :integer
  end
end
