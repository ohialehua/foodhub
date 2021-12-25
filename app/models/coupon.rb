class Coupon < ApplicationRecord

  belongs_to :store
  belongs_to :enduser
end
