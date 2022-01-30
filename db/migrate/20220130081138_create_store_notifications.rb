class CreateStoreNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :store_notifications do |t|

      t.integer :store_id, null: false
      t.integer :enduser_id, null: false
      t.integer :store_order_id
      t.integer :post_id
      t.integer :comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
