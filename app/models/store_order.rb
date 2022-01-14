class StoreOrder < ApplicationRecord

  has_many :order_details
  belongs_to :store
  belongs_to :order

  enum order_status: { payment_waiting: 0, payment_finish: 1, production: 2, ready_to_delivery: 3, delivery_finish: 4 }

end
