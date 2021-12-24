class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|

      t.integer :enduser_id
      t.integer :room_id

      t.timestamps
    end
  end
end
