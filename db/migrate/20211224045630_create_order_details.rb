class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|

      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :order_quantity, null: false
      t.integer :price_after_tax, null: false
      t.integer :product_status,default: 0,null: false

      t.timestamps
    end
  end
end
