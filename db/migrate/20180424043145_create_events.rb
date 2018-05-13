class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :subject
      t.text :description
      t.string :venue
      t.datetime :event_date
      t.integer :event_price
      t.string :purchase_id

      t.timestamps
    end
  end
end
