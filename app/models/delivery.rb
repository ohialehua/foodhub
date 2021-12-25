class Delivery < ApplicationRecord

  belongs_to :enduser

  def full_address
    '〒'+post_address+' '+address
  end
end
