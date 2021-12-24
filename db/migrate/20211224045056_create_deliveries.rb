class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|

      t.integer :enduser_id
      t.string :full_name
      t.string :full_name_kana
      t.string :email
      t.string :post_address
      t.string :address

      t.timestamps
    end
  end
end
