class StoreOrder < ApplicationRecord

  has_many :order_details
  belongs_to :enduser
  belongs_to :store
  belongs_to :order
  has_many :store_notifications, dependent: :destroy

  enum order_status: { payment_waiting: 0, payment_finish: 1, production: 2, ready_to_delivery: 3, delivery_finish: 4 }

  def self.search(search)
   if search == "発送完了"
     @store_orders = StoreOrder.where("order_status","delivery_finish")
   elsif search =="未発送"
     @store_orders = StoreOrder.where.not("order_status","delivery_finish")
   else
     @store_orders = StoreOrder.all
   end
  end

end
