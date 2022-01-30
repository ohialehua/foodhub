class CreatePublicNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :public_notifications do |t|
      
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.integer :post_id
      t.integer :comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
