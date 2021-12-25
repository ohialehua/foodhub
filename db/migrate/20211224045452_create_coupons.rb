class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|

      t.integer :store_id, null: false
      t.string :discount, null: false, default: ""
      t.string :reason, null: false, default: ""
      t.boolean :is_active,null: false, default: true
      t.integer :limit, null: false

      t.timestamps
    end
  end
end
