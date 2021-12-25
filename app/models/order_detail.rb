class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum product_status: { not_yet:0,waiting:1,working:2,complete:3}

  def subtotal
     item.with_tax_price*order_quantity
  end
end
