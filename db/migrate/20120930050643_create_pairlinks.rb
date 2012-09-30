class CreatePairlinks < ActiveRecord::Migration
  def change
    create_table :pairlinks do |t|
      t.string :url
      t.string :tamaki_url

      t.timestamps
    end
  end
end
