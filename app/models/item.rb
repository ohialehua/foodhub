class Item < ApplicationRecord
  
 belongs_to :store
 belongs_to :genre
 has_many :cart_items
 has_many :endusers,through: :cart_items

 has_many :order_items
 has_many :orders,through: :order_items

 attachment :image
 
 validates :name,presence:true
 validates :body,presence:true
 validates :price_before_tax,presence:true

 def with_tax_price
  (price_before_tax * 1.1).floor
 end
 
end
