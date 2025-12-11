class CreateOnigiriEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :onigiri_events do |t|
      t.integer :onigiri_id
      t.integer :event_id
      t.float :unit_cost
      t.float :unit_profit
      t.integer :quantity_brought
      t.integer :quantity_sold

      t.timestamps
    end
  end
end
