class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|

      t.integer :store_id
      t.string :discount
      t.string :reason
      t.boolean :is_active,null: false, default: true
      t.integer :limit

      t.timestamps
    end
  end
end
