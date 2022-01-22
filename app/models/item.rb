class Item < ApplicationRecord

 belongs_to :store
 belongs_to :genre
 has_many :cart_items
 has_many :endusers,through: :cart_items

 has_many :order_details
 has_many :orders,through: :order_details

 attachment :image

 validates :name,presence:true
 validates :body,presence:true
 validates :image,presence:true
 validates :price_before_tax,presence:true

 def with_tax_price
  (price_before_tax * 1.1).floor
 end

 def self.sort(selection)
	  if selection == 'bought'
	    @items = Item.left_joins(:order_details).group(:id).order(Arel.sql('count(item_id) desc'))
	  elsif selection == 'new'
	    @items = Item.all.order(created_at: :DESC)
	  elsif selection == 'old'
	    @items = Item.all.order(created_at: :ASC)
	  else
	    @items = Item.all.order(impressions_count: :DESC)
   end
	end

end
