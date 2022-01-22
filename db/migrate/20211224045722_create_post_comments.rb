class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|

      t.integer :store_id
      t.integer :enduser_id
      t.integer :post_id, null: false
      t.text :comment

      t.timestamps
    end
  end
end
