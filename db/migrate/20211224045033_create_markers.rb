class CreateMarkers < ActiveRecord::Migration[5.2]
  def change
    create_table :markers do |t|

      t.integer :enduser_id
      t.integer :store_id

      t.timestamps
    end
  end
end
