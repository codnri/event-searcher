class AddRefsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :attend, foreign_key: true
    # add_reference :events, :host_user, foreign_key: true
  end
end
