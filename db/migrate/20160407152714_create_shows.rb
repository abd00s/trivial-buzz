class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.integer :show_number
      t.date :air_date

      t.timestamps null: false
    end
  end
end
