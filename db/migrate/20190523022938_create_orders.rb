class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :buyer_id
      t.string :bought_id

      t.timestamps
    end
    add_index :orders, :buyer_id
    add_index :orders, :bought_id
    add_index :orders, [:buyer_id, :bought_id], unique: true
  end
end
