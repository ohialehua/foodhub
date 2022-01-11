class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|

      t.integer :store_id, null: false
      t.integer :enduser_id, null: false
      t.integer :post_id, null: false
      t.text :comment, null: false, default: ""

      t.timestamps
    end
  end
end
