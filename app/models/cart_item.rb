class CartItem < ApplicationRecord

  belongs_to :enduser
  belongs_to :item

  def subtotal
    item.with_tax_price*quantity
  end

end
