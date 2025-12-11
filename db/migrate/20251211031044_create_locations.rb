class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.float :location_distance

      t.timestamps
    end
  end
end
