class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :name
      t.integer :show_id

      t.timestamps null: false
    end
  end
end
