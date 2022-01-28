class CartItem < ApplicationRecord

  belongs_to :enduser
  belongs_to :item

  def subtotal #商品ごとの小計
    item.with_tax_price*quantity
  end

end
