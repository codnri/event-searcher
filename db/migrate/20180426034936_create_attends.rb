class CreateAttends < ActiveRecord::Migration[5.1]
  def change
    create_table :attends do |t|
      t.string :status
      t.string :secret_url
      t.references :guest_user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
