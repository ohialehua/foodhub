class StoreOrder < ApplicationRecord

  has_many :order_details
  belongs_to :store
  
end
