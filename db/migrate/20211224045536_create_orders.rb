class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :enduser_id, null: false
      t.integer :store_id, null: false
      t.string :post_address, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :full_name, null: false, default: ""
      t.integer :postage, null: false
      t.integer :total_price, null: false
      t.integer :order_status,default: 0,null: false
      t.integer :pay_method,default: 0,null: false

      t.timestamps
    end
  end
end
