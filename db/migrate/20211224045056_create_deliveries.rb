class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|

      t.integer :enduser_id, null: false
      t.string :full_name, null: false, default: ""
      t.string :full_name_kana, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :post_address, null: false, default: ""
      t.string :address, null: false, default: ""

      t.timestamps
    end
  end
end
