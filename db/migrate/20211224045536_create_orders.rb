class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :enduser_id
      t.integer :store_id
      t.string :post_address
      t.string :address
      t.string :full_name
      t.integer :postage
      t.integer :total_price
      t.integer :order_status,default: 0
      t.integer :pay_method,default: 0

      t.timestamps
    end
  end
end
