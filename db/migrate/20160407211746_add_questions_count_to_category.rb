class AddQuestionsCountToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :questions_count, :integer, default: 0
  end
end
