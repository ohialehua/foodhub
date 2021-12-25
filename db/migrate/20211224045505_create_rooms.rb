class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|

      t.integer :enduser_id, null: false

      t.timestamps
    end
  end
end
