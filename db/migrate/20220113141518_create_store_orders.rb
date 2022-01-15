class CreateStoreOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :store_orders do |t|

      t.integer :enduser_id, null: false
      t.integer :store_id, null: false
      t.integer :order_id, null: false
      t.integer :order_status,default: 0,null: false

      t.timestamps
    end
  end
end
