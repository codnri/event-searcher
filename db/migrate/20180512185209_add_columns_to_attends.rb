class AddColumnsToAttends < ActiveRecord::Migration[5.1]
  def change
    add_column :attends, :stripe_id, :string
    add_column :attends, :amount, :integer
    add_column :attends, :card_brand, :string
    add_column :attends, :card_last4, :string
    add_column :attends, :card_exp_month, :string
    add_column :attends, :card_exp_year, :string
  end
end
