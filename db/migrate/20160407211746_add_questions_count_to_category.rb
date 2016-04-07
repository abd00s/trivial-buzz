class AddQuestionsCountToCategory < ActiveRecord::Migration
  def change
    add_column :category, :questions_count, :integer, default: 0
  end
end
