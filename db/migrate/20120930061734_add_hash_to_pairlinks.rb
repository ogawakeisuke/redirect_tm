class AddHashToPairlinks < ActiveRecord::Migration
  def change
    add_column :pairlinks, :digested_hash, :string
  end
end
