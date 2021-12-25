class CreateMarkers < ActiveRecord::Migration[5.2]
  def change
    create_table :markers do |t|

      t.integer :enduser_id, null: false
      t.integer :store_id, null: false

      t.timestamps
    end
  end
end
