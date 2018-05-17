class RemoveHostUserIdFromEvents < ActiveRecord::Migration[5.1]
  def change
    # remove_reference :events, :host_user, index: true
  end
end
