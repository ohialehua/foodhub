class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|

      t.integer :enduser_id
      t.integer :room_id
      t.text :message

      t.timestamps
    end
  end
end
