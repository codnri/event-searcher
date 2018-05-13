class RemoveAttendrefFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_reference :events, :attend, foreign_key: true
  end
end
