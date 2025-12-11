class CreateOnigiris < ActiveRecord::Migration[8.0]
  def change
    create_table :onigiris do |t|
      t.string :onigiri_flavor

      t.timestamps
    end
  end
end
