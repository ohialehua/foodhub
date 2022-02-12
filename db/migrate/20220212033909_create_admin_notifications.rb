class CreateAdminNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_notifications do |t|

      t.integer :admin_id, null: false
      t.integer :store_id, null: false
      t.boolean :checked, default: false, null: false
      
      t.timestamps
      
    end
  end
end
