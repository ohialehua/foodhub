class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item
  belongs_to :store
  belongs_to :store_order

  enum product_status: { not_yet:0,waiting:1,working:2,complete:3}

  def subtotal
     item.with_tax_price*order_quantity
  end

  scope :rank, -> (count) {group(:item_id).order('count(item_id) desc').limit(count)}
end
