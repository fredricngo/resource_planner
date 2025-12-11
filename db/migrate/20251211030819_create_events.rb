class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :event_name
      t.integer :event_location
      t.datetime :event_date
      t.float :application_fee
      t.float :participation_fee
      t.integer :event_duration
      t.float :hourly_labor
      t.float :mile_reimbursement
      t.integer :created_by

      t.timestamps
    end
  end
end
