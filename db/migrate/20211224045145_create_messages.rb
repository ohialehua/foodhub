class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|

      t.integer :enduser_id, null: false
      t.integer :room_id, null: false
      t.text :message, null: false, default: ""

      t.timestamps
    end
  end
end
