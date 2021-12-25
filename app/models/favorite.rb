class Favorite < ApplicationRecord
  
  belongs_to :enduser
  belongs_to :post
  
end
