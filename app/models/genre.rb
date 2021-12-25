class Genre < ApplicationRecord
  
  belongs_to :store
  has_many :items
  
  validates :name,presence:true
end
