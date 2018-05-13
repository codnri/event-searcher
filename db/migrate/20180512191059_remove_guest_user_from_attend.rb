class RemoveGuestUserFromAttend < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :attends, :guest_users
    remove_reference :attends, :guest_user, foreign_key: true
  end
end
