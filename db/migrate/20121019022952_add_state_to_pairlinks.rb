class AddStateToPairlinks < ActiveRecord::Migration
  def change
    add_column :pairlinks, :state, :integer
  end
end
