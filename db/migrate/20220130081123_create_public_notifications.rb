class CreatePublicNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :public_notifications do |t|

      t.integer :sender_id
      t.integer :receiver_id
      t.integer :store_id
      t.integer :enduser_id
      t.integer :store_order_id
      t.integer :post_id
      t.integer :post_comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
