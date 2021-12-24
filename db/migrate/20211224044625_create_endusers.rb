class CreateEndusers < ActiveRecord::Migration[5.2]
  def change
    create_table :endusers do |t|

      t.timestamps
    end
  end
end
