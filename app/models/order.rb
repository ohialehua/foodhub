class Order < ApplicationRecord

  belongs_to :enduser
  has_many :order_details
  has_many :items,through: :order_details
  has_many :store_orders
  has_many :stores,through: :store_orders

  enum pay_method: { credit_card: 0, transfer: 1 }
  validates :post_address,presence:true
  validates :address,presence:true
  validates :name,presence:true

  def sum_order_price
    total_price+postage
  end

   def with_tax_price
  (price_before_tax * 1.1).floor
   end

end
