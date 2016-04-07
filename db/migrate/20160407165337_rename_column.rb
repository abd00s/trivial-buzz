class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :questions, :show_id, :round_id
  end
end
