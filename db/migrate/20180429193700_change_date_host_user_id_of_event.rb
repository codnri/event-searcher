class ChangeDateHostUserIdOfEvent < ActiveRecord::Migration[5.1]
  def change
        # remove_column :events, :host_user
        # remove_column :events, user:reference
        
        add_reference :events, :user, foreign_key: true

  end
end
