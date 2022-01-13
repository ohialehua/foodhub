class CreateStoreOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :store_orders do |t|

      t.timestamps
    end
  end
end
