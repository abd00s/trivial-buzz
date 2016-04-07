class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :body
      t.text :response
      t.integer :value

      t.timestamps null: false
    end
  end
end
