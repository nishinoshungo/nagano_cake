class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :shipping, null: false
      t.integer :price, null: false
      t.integer :order_status, null: false, default: 1
      t.timestamps
    end
  end
end
