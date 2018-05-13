class AddUserToAttends < ActiveRecord::Migration[5.1]
  def change
    add_reference :attends, :user, foreign_key: true
  end
end
