class CreateAccommodations < ActiveRecord::Migration[5.0]
  def change
    create_table :accommodations do |t|
      t.integer :user_id
      t.integer :trip_id
      t.string :location
      t.datetime :check_in
      t.datetime :check_out

      t.timestamps
    end
  end
end
