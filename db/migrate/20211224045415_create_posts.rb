class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :store_id
      t.integer :enduser_id
      t.string :post_image_id, null: false
      t.text :body, null: false
      t.integer :impressions_count, default: 0

      t.timestamps
    end
  end
end
