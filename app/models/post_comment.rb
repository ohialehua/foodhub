class PostComment < ApplicationRecord

  belongs_to :store
  belongs_to :enduser
  belongs_to :post

  validates :comment, presence: true
end
